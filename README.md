# vgram

**vgram** is a bot library for the Telegram Bot API written in V.
The Bot API is an HTTP-based interface created for developers keen on building bots for Telegram.

It implements every type and method from **Telegram Bot API 10.1.0**. The V
bindings (`types.v`, `methods.v`, `vgram.v`) are generated from the official API
schema by the generator in [`gen/`](gen/), so they can be regenerated whenever
Telegram updates the API.

## Installing

`$ v install dariotarantini.vgram`

## Getting started

1. Search for the "@botfather" telegram bot and start it
2. Click on or type /newbot to create a new bot and follow his instructions
3. Copy the token and create a file named `send_message.v` with the following code:
```v
module main

import dariotarantini.vgram

fn main() {
	bot := vgram.new_bot('TELEGRAM_BOT_TOKEN_HERE')
	bot.send_message(
		chat_id: 'USER_ID_HERE'
		text:    'yo! Made using vgram!'
	) or { panic(err) }
}
```

## Examples

* [`hi_man.v`](examples/hi_man.v) - a complete Telegram bot written in V
* [`send_photo.v`](examples/send_photo.v) - uploading a local file via multipart/form-data

## Documentation

You can find the documentation directly on the [Telegram website](https://core.telegram.org/bots/api),
or read it in the vgram source code: see [`methods.v`](methods.v) and [`types.v`](types.v).

Call a method using:
```v
result := bot_instance.method_name(
	method_arg1: 'some text'
	method_arg2: 123 // or int
)!
```
- *bot_instance* can be created using `vgram.new_bot('TOKEN')`
- *method_name* and *method_args* should be in snake_case
- every method returns a Result (`!T`): handle it with `!` or `or { ... }`

### Notes on the generated bindings

- Integer fields use `i64` (Telegram chat / user ids exceed 32 bits).
- Large nested objects (e.g. `Update.message`, `Message.reply_to_message`) are
  optional references (`?&Type`); small structs like `User`/`Chat` stay values.
  Unwrap a reference once, then access values normally:
  ```v
  if msg := update.message {
  	id := msg.from.id // `from` is a value, no further unwrapping
  }
  ```
  (References keep structs small; V's json decoder stack-allocates the whole
  struct tree, so embedding everything by value would overflow the stack.)
- Complex method parameters (objects, keyboards, media, unions) are typed as
  `string`; pass `json.encode(...)` of the relevant struct.

## Errors

Every method returns `!T`. On failure you get either the underlying transport
error, or a `vgram.TelegramError` when the API replies with `ok: false`:

```v
msg := bot.send_message(chat_id: id, text: 'hi') or {
	if err is vgram.TelegramError {
		// err.code, err.description, err.retry_after, err.migrate_to_chat_id
		eprintln('telegram said: ${err.code} ${err.description}')
	}
	return err
}
```

`TelegramError` exposes `retry_after` (flood control / HTTP 429) and
`migrate_to_chat_id` from Telegram's response `parameters`.

## Configuration

`Bot` fields can be set after construction:

```v
mut bot := vgram.new_bot('TOKEN')
bot.endpoint = 'http://localhost:8081/bot' // e.g. a local Bot API server
bot.timeout = 60 * time.second             // per-request read/write timeout (0 = no timeout)
bot.debug = true                           // log requests/responses to stderr
bot.headers['X-Custom'] = 'value'          // extra headers on every request
```

For API methods that don't have a generated helper yet, call them directly with
the generic, public request method (it returns the raw JSON of the `result`
field):

```v
raw := bot.http_request('someNewMethod', json.encode(params))!
```

## Uploading files

File parameters (`photo`, `document`, ...) accept a `file_id` or an HTTP URL as
a plain string. To upload a *local* file, use `http_request_files`, which sends
`multipart/form-data`:

```v
import json

photo := vgram.input_file_from_path('cat.jpg')!
raw := bot.http_request_files('sendPhoto',
	{'chat_id': '123456', 'caption': 'look at this'},
	{'photo': [photo]})!
msg := json.decode(vgram.Message, raw)!
```

`form` holds the textual parameters (including the `json.encode(...)` of any
complex ones, e.g. `reply_markup`); `files` maps each file field to its
contents. `input_file_from_path` reads a file from disk; you can also build an
`http.FileData{filename, content_type, data}` yourself.

## Regenerating the bindings

The library files are produced from `gen/botapi.json`. To regenerate them (after
updating the schema, for example):
```sh
v run gen                 # reads gen/botapi.json, writes types.v, methods.v, vgram.v at the module root
v run gen <schema> <dir>  # optional: custom input file and output directory
```
The generator formats its output with `v fmt` automatically.
