// gen.v vgram code generator.
//
// Reads the Telegram Bot API schema (botapi.json) and emits valid, modern V
// for the `vgram` module:
//
//   - types.v   : every Bot API object as a V struct
//   - methods.v : a `@[params]` config struct + a `Bot` method per API method
//   - vgram.v   : the `Bot` type and the HTTP/JSON plumbing
//
// Usage:
//
//   v run gen                 # reads gen/botapi.json, writes the *.v files at the module root
//   v run gen <schema> <dir>  # custom input file and output directory
//
// Notes on the generated V output:
//   - Attributes use the modern `@[...]` form: @[params], @[omitempty], @[raw],
//     @[json: 'name'].
//   - `int` is mapped to `i64` and `float` to `f64`; Telegram chat / user ids
//     exceed 32 bits, so i64 avoids silent overflow.
//   - Recursive object fields (e.g. Message.reply_to_message) are emitted as
//     `?&Type`. V's json codec decodes an absent value to `none` and omits a
//     `none` reference on encode, which breaks the otherwise infinite struct
//     size while keeping (de)serialisation correct.
//   - Abstract Bot API types (those with `extended_by` and no own fields, e.g.
//     ChatMember, ReactionType) are flattened into a single struct holding the
//     union of all subtype fields, so json.decode of any concrete variant works.
//   - Complex method parameters (objects, abstract types, unions, arrays of
//     objects, InputFile) are typed as `string`: pass `json.encode(...)`.
module main

import os
import json
import strings

// Schema shapes

struct Field {
	name        string
	types       []string
	optional    bool
	description string
}

struct TypeDef {
	name        string
	description string
	fields      []Field
	extended_by []string
}

struct MethodDef {
	name         string
	description  string
	fields       []Field
	return_types []string
}

struct Spec {
	version string
	types   []TypeDef
	methods []MethodDef
}

// V helpers

const v_keywords = ['as', 'asm', 'assert', 'atomic', 'break', 'const', 'continue', 'defer', 'else',
	'enum', 'false', 'fn', 'for', 'go', 'goto', 'if', 'import', 'in', 'interface', 'is', 'isreftype',
	'lock', 'match', 'module', 'mut', 'none', 'or', 'pub', 'return', 'rlock', 'select', 'shared',
	'sizeof', 'spawn', 'static', 'struct', 'true', 'type', 'typeof', 'union', 'unsafe', 'volatile',
	'__global', '__offsetof']

fn is_scalar(token string) bool {
	return token in ['int', 'float', 'bool', 'string']
}

fn scalar_vtype(token string) string {
	return match token {
		'int' { 'i64' }
		'float' { 'f64' }
		'bool' { 'bool' }
		'string' { 'string' }
		else { 'string' }
	}
}

fn is_scalar_array(token string) bool {
	if !token.starts_with('Array<') || !token.ends_with('>') {
		return false
	}
	return is_scalar(token#[6..-1])
}

// Collapse all whitespace runs into single spaces so a description fits on one
// comment line. Iterating bytes is safe: multi-byte UTF-8 bytes are all >= 0x80
// and never match an ASCII whitespace byte.
fn clean_desc(s string) string {
	mut b := strings.new_builder(s.len)
	mut prev_space := false
	for c in s {
		if c == ` ` || c == `\t` || c == `\n` || c == `\r` {
			if !prev_space {
				b.write_u8(` `)
				prev_space = true
			}
		} else {
			b.write_u8(c)
			prev_space = false
		}
	}
	return b.str().trim_space()
}

// getUpdates -> get_updates
fn camel_to_snake(s string) string {
	mut b := strings.new_builder(s.len + 8)
	for c in s {
		if c >= `A` && c <= `Z` {
			b.write_u8(`_`)
			b.write_u8(c + 32)
		} else {
			b.write_u8(c)
		}
	}
	mut r := b.str()
	if r.starts_with('_') {
		r = r[1..]
	}
	return r
}

// getUpdates -> GetUpdates
fn pascal(s string) string {
	if s.len == 0 {
		return s
	}
	return s[0..1].to_upper() + s[1..]
}

// Generator

struct Edge {
	field  string
	target string
}

struct ReturnInfo {
	ret_type string
	decode   string
}

// Object fields whose target struct is at least this many (estimated) bytes are
// emitted as `?&` references rather than embedded by value. This keeps structs
// small: V's json decoder stack-allocates the whole struct tree, so embedding
// large objects (e.g. an Update holds several Messages, each ~35 KB of nested
// value structs) overflows the stack. Small structs (User, Chat, ~96 B) stay
// values so common field access (`msg.from.id`) needs no unwrapping.
const size_threshold = 512

struct Generator {
mut:
	spec          Spec
	struct_names  map[string]bool
	types_by_name map[string]TypeDef
	fields_cache  map[string][]Field
	size_cache    map[string]int
	// keys "Owner#field" whose single-object reference must be a `?&` pointer.
	back_edges map[string]bool
}

fn new_generator(spec Spec) Generator {
	mut g := Generator{
		spec: spec
	}
	for t in spec.types {
		g.struct_names[t.name] = true
		g.types_by_name[t.name] = t
	}
	g.compute_back_edges()
	for name, _ in g.struct_names {
		g.intrinsic_size(name)
	}
	return g
}

// intrinsic_size estimates sizeof(struct) treating every object field as
// embedded by value, except recursion back edges (counted as an 8-byte
// reference). It is the criterion for the size threshold; the back-edge pass
// has already made the value graph acyclic, so the recursion terminates.
fn (mut g Generator) intrinsic_size(name string) int {
	if name in g.size_cache {
		return g.size_cache[name]
	}
	g.size_cache[name] = 8 // guard for any residual cycle
	mut total := 0
	for f in g.final_fields(name) {
		total += g.field_size(name, f)
	}
	g.size_cache[name] = total
	return total
}

fn (mut g Generator) field_size(owner string, f Field) int {
	if f.types.len > 1 {
		return 16 // union -> string
	}
	tk := f.types[0]
	if tk.starts_with('Array<') {
		return 48 // slice header
	}
	if is_scalar(tk) {
		return if tk == 'string' {
			16
		} else if tk == 'bool' {
			4
		} else {
			8
		}
	}
	if tk in g.struct_names {
		if '${owner}#${f.name}' in g.back_edges {
			return 8
		}
		return g.intrinsic_size(tk)
	}
	return 16
}

// is_ref_field reports whether a single-object field should be a `?&` reference:
// either it closes a recursion cycle, or its target struct is large.
fn (g &Generator) is_ref_field(owner string, f Field) bool {
	target := g.single_object_target(f)
	if target == '' {
		return false
	}
	return '${owner}#${f.name}' in g.back_edges || g.size_cache[target] > size_threshold
}

// Final field list for a type: its own fields, or the merged fields of every
// `extended_by` subtype for abstract types (deduped by field name).
fn (mut g Generator) final_fields(name string) []Field {
	if name in g.fields_cache {
		return g.fields_cache[name]
	}
	g.fields_cache[name] = []Field{} // guard against accidental cycles
	mut res := []Field{}
	if name in g.types_by_name {
		def := g.types_by_name[name]
		if def.fields.len > 0 {
			res = def.fields.clone()
		} else if def.extended_by.len > 0 {
			mut seen := map[string]bool{}
			for sub in def.extended_by {
				for f in g.final_fields(sub) {
					if f.name !in seen {
						seen[f.name] = true
						res << f
					}
				}
			}
		}
	}
	g.fields_cache[name] = res
	return res
}

fn is_abstract(t TypeDef) bool {
	return t.fields.len == 0 && t.extended_by.len > 0
}

// A field is a value edge in the struct-size graph only when it is a single
// (non-array) object whose type is one of our structs. Arrays, scalars and
// unions never make a struct infinitely sized.
fn (g &Generator) single_object_target(f Field) string {
	if f.types.len != 1 {
		return ''
	}
	tk := f.types[0]
	if is_scalar(tk) || tk.starts_with('Array<') || tk.contains('|') {
		return ''
	}
	return if tk in g.struct_names { tk } else { '' }
}

// DFS over value edges; every back edge (to a node on the stack) is turned into
// a `?&` reference. Removing back edges yields a DAG, i.e. finite struct sizes,
// while keeping the minimum number of pointer fields.
fn (mut g Generator) compute_back_edges() {
	mut adj := map[string][]Edge{}
	for name, _ in g.struct_names {
		mut edges := []Edge{}
		for f in g.final_fields(name) {
			target := g.single_object_target(f)
			if target != '' {
				edges << Edge{
					field:  f.name
					target: target
				}
			}
		}
		adj[name] = edges
	}
	mut state := map[string]int{} // 1 = on stack, 2 = done
	for name, _ in g.struct_names {
		if state[name] == 0 {
			g.dfs(name, mut state, adj)
		}
	}
}

fn (mut g Generator) dfs(node string, mut state map[string]int, adj map[string][]Edge) {
	state[node] = 1
	for e in adj[node] {
		st := state[e.target]
		if st == 1 {
			g.back_edges['${node}#${e.field}'] = true
		} else if st == 0 {
			g.dfs(e.target, mut state, adj)
		}
	}
	state[node] = 2
}

// Map a single type token to a V type for response structs (types.v).
fn (g &Generator) token_to_vtype(token string) string {
	if token.starts_with('Array<') && token.ends_with('>') {
		return '[]' + g.token_to_vtype(token#[6..-1])
	}
	if token.contains('|') {
		return 'string' // array-of-union fallback
	}
	if is_scalar(token) {
		return scalar_vtype(token)
	}
	return if token in g.struct_names { token } else { 'string' }
}

// Render one field of a response struct (types.v).
fn (g &Generator) emit_type_field(owner string, f Field, force_optional bool) string {
	mut attrs := []string{}
	mut ident := f.name
	if f.name in v_keywords {
		ident = '@' + f.name
		attrs << "json: '${f.name}'"
	}

	mut vtype := ''
	mut is_union := false
	if f.types.len > 1 {
		// The only field-level union in response types is `int | string`.
		// Capture it raw so either shape decodes into a string.
		vtype = 'string'
		is_union = true
	} else {
		tk := f.types[0]
		if is_scalar(tk) {
			vtype = scalar_vtype(tk)
		} else if tk.starts_with('Array<') {
			vtype = g.token_to_vtype(tk)
		} else if tk in g.struct_names {
			vtype = if g.is_ref_field(owner, f) { '?&' + tk } else { tk }
		} else {
			vtype = 'string'
		}
	}

	// Attributes in V's canonical (vfmt) order: json, omitempty, raw.
	if force_optional || f.optional {
		attrs << 'omitempty'
	}
	if is_union {
		attrs << 'raw'
	}
	attr_str := if attrs.len > 0 { ' @[' + attrs.join('; ') + ']' } else { '' }
	return '${ident} ${vtype}${attr_str}'
}

// Render one field of a method config struct (methods.v).
fn (g &Generator) emit_param_field(f Field) string {
	mut attrs := []string{}
	mut ident := f.name
	if f.name in v_keywords {
		ident = '@' + f.name
		attrs << "json: '${f.name}'"
	}

	mut vtype := ''
	mut note := ''
	if f.types.len > 1 {
		vtype = 'string'
		note = 'JSON-serialized: ' + f.types.join(' | ')
	} else {
		tk := f.types[0]
		if is_scalar(tk) {
			vtype = scalar_vtype(tk)
		} else if is_scalar_array(tk) {
			vtype = '[]' + scalar_vtype(tk#[6..-1])
		} else {
			// Objects, abstract types, arrays of objects, InputFile, …
			vtype = 'string'
			note = 'JSON-serialized: ' + tk
		}
	}

	if f.optional {
		attrs << 'omitempty'
	}
	attr_str := if attrs.len > 0 { ' @[' + attrs.join('; ') + ']' } else { '' }

	desc := clean_desc(f.description)
	prefix := if note != '' { '[${note}] ' } else { '' }
	comment := if prefix != '' || desc != '' { ' // ${prefix}${desc}' } else { '' }
	return '${ident} ${vtype}${attr_str}${comment}'
}

// V return type + decode statement for a method's primary return token. Every
// method returns a Result (`!T`); transport and API errors propagate to the
// caller instead of being swallowed.
fn (g &Generator) return_handling(token string) ReturnInfo {
	match token {
		'bool' { return ReturnInfo{'!bool', "return resp == 'true'"} }
		'int' { return ReturnInfo{'!i64', 'return resp.i64()'} }
		'float' { return ReturnInfo{'!f64', 'return resp.f64()'} }
		'string' { return ReturnInfo{'!string', 'return resp.trim(\'"\')'} }
		else {}
	}

	v := g.token_to_vtype(token)
	return ReturnInfo{'!${v}', 'return json.decode(${v}, resp)!'}
}

fn (g &Generator) header(file string) string {
	return
		'// ${file} generated by gen.v from the Telegram Bot API schema (Bot API ${g.spec.version}).\n' + '// Do not edit by hand; re-run the generator (v run gen) instead.\n\n' +
		'module vgram\n'
}

fn (mut g Generator) build_types() string {
	mut b := strings.new_builder(400_000)
	b.write_string(g.header('types.v'))
	// The response envelope (ApiResponse) and error type live in vgram.v.

	for t in g.spec.types {
		fields := g.final_fields(t.name)
		abstract := is_abstract(t)
		b.write_string('\n')
		desc := clean_desc(t.description)
		if desc != '' {
			b.write_string('// ${t.name} ${desc}\n')
		}
		if abstract {
			b.write_string('// Abstract type: one of ${t.extended_by.join(', ')}. Fields below are the merged superset of every variant.\n')
		}
		b.write_string('pub struct ${t.name} {\n')
		if fields.len > 0 {
			b.write_string('pub mut:\n')
			for f in fields {
				fdesc := clean_desc(f.description)
				if fdesc != '' {
					b.write_string('\t// ${fdesc}\n')
				}
				b.write_string('\t${g.emit_type_field(t.name, f, abstract)}\n')
			}
		}
		b.write_string('}\n')
	}
	return b.str()
}

fn (mut g Generator) build_methods() string {
	mut b := strings.new_builder(300_000)
	b.write_string(g.header('methods.v'))
	b.write_string('\nimport json\n')

	for m in g.spec.methods {
		snake := camel_to_snake(m.name)
		has_fields := m.fields.len > 0
		cfg_name := 'Config' + pascal(m.name)
		desc := clean_desc(m.description)

		b.write_string('\n')
		if desc != '' {
			b.write_string('// ${snake} ${desc}\n')
		}

		if has_fields {
			b.write_string('@[params]\npub struct ${cfg_name} {\npub mut:\n')
			for f in m.fields {
				b.write_string('\t${g.emit_param_field(f)}\n')
			}
			b.write_string('}\n')
		}

		token := if m.return_types.len > 0 { m.return_types[0] } else { 'bool' }
		ri := g.return_handling(token)
		if m.return_types.len > 1 {
			b.write_string('// Returns one of: ${m.return_types.join(', ')} (decoded here as ${ri.ret_type.trim_left('!')}).\n')
		}

		arg := if has_fields { 'conf ${cfg_name}' } else { '' }
		body := if has_fields { 'json.encode(conf)' } else { "'{}'" }
		b.write_string('pub fn (b Bot) ${snake}(${arg}) ${ri.ret_type} {\n')
		b.write_string("\tresp := b.http_request('${m.name}', ${body})!\n")
		b.write_string('\t${ri.decode}\n')
		b.write_string('}\n')
	}
	return b.str()
}

fn (g &Generator) build_vgram() string {
	header :=
		'// vgram.v generated by gen.v from the Telegram Bot API schema (Bot API ${g.spec.version}).\n' + '// Do not edit by hand; re-run the generator (v run gen) instead.\n'
	// Raw string: the `${...}` below are literal V interpolations in the output.
	body := r"
module vgram

import net.http
import time
import json

// TelegramError is returned when the Bot API replies with `ok: false`. It
// implements IError, so it can be matched inside an `or { ... }` block:
//
//   msg := bot.send_message(chat_id: id, text: 'hi') or {
//       if err is vgram.TelegramError && err.retry_after > 0 {
//           // flood control: wait err.retry_after seconds and try again
//       }
//       return err
//   }
pub struct TelegramError {
pub:
	code               int    // Telegram error_code, e.g. 400, 401, 403, 409, 429
	description        string // human-readable description from Telegram
	migrate_to_chat_id i64    // set when a group has been migrated to a supergroup
	retry_after        i64    // seconds to wait before retrying (flood control, 429)
}

pub fn (e TelegramError) msg() string {
	return 'telegram: ${e.code} ${e.description}'
}

pub fn (e TelegramError) code() int {
	return e.code
}

// ApiResponse is the envelope wrapping every Bot API reply. ResponseParameters
// is a generated Bot API type (see types.v).
struct ApiResponse {
	ok          bool
	result      string @[raw]
	error_code  int
	description string
	parameters  ResponseParameters
}

pub struct Bot {
pub mut:
	token string
	// Base endpoint; the bot token and method name are appended. Override to
	// use a local Bot API server.
	endpoint string = 'https://api.telegram.org/bot'
	// Per-request read/write timeout. Set to 0 to wait indefinitely.
	timeout time.Duration = 30 * time.second
	// When true, outgoing requests and raw responses are logged to stderr.
	debug bool
	// Extra HTTP headers sent with every request (e.g. for a proxy).
	headers map[string]string
}

// new_bot creates a new Bot from a Telegram bot token.
pub fn new_bot(token string) Bot {
	return Bot{
		token: token
	}
}

// http_request performs a POST request against the Telegram Bot API and returns
// the raw JSON of the response `result` field. It returns a TelegramError when
// the API replies with `ok: false`, or the underlying transport error when the
// request itself fails. It is public so callers can invoke API methods that are
// not (yet) wrapped by a generated helper.
pub fn (b Bot) http_request(method string, data string) !string {
	mut header := http.new_header(key: .content_type, value: 'application/json')
	header.add_custom_map(b.headers)!
	mut req := http.Request{
		method:        .post
		url:           '${b.endpoint}${b.token}/${method}'
		data:          data
		header:        header
		read_timeout:  b.timeout
		write_timeout: b.timeout
	}
	if b.debug {
		eprintln('vgram request ${method}: ${data}')
	}
	resp := req.do()!
	if b.debug {
		eprintln('vgram response ${resp.status_code}: ${resp.body}')
	}
	api := json.decode(ApiResponse, resp.body) or {
		return error('vgram: invalid JSON in response to ${method}: ${err}')
	}
	if !api.ok {
		return TelegramError{
			code:               api.error_code
			description:        api.description
			migrate_to_chat_id: api.parameters.migrate_to_chat_id
			retry_after:        api.parameters.retry_after
		}
	}
	return api.result
}
"
	return header + body
}

fn main() {
	// Defaults resolve relative to the module root (the folder holding v.mod),
	// so `v run gen` works regardless of the current working directory.
	input := if os.args.len > 1 { os.args[1] } else { os.join_path(@VMODROOT, 'gen', 'botapi.json') }
	outdir := if os.args.len > 2 { os.args[2] } else { @VMODROOT }

	raw := os.read_file(input) or {
		eprintln('gen: failed to read ${input}: ${err}')
		exit(1)
	}
	spec := json.decode(Spec, raw) or {
		eprintln('gen: failed to parse ${input}: ${err}')
		exit(1)
	}
	mut g := new_generator(spec)

	files := {
		'types.v':   g.build_types()
		'methods.v': g.build_methods()
		'vgram.v':   g.build_vgram()
	}
	mut written := []string{}
	for name, content in files {
		path := os.join_path(outdir, name)
		os.write_file(path, content) or {
			eprintln('gen: failed to write ${path}: ${err}')
			exit(1)
		}
		written << path
		println('wrote ${path} (${content.len} bytes)')
	}

	// Delegate canonical formatting (field/comment alignment, attribute order)
	// to the official formatter. Best-effort: the emitted source is already
	// valid V, so a missing `v` is not fatal.
	res := os.execute('v fmt -w ${written.join(' ')}')
	if res.exit_code == 0 {
		println('formatted output with `v fmt -w`')
	} else {
		println('note: `v fmt` unavailable or failed (output is still valid V)')
	}

	mut ref_fields := 0
	for name, _ in g.struct_names {
		for f in g.final_fields(name) {
			if g.is_ref_field(name, f) {
				ref_fields++
			}
		}
	}
	println('done: ${g.spec.types.len} types, ${g.spec.methods.len} methods (Bot API ${g.spec.version}), ${ref_fields} reference fields (${g.back_edges.len} recursive).')
}
