module main

import dariotarantini.vgram
import json

// A bot that uploads a local image via multipart/form-data when it receives
// `/photo`. Set your token and the image path below, then run with:
//
//   v run examples/send_photo.v
const photo_path = 'examples/cat.jpg'

fn main() {
	bot := vgram.new_bot('API_TOKEN')
	mut offset := i64(0)
	for {
		updates := bot.get_updates(offset: offset, limit: 100, timeout: 20) or { continue }
		for update in updates {
			offset = update.update_id + 1
			// `message` is an optional reference (?&Message); skip non-message updates.
			msg := update.message or { continue }
			if msg.text == '/photo' {
				// Read the local file, then upload it as the `photo` field.
				photo := vgram.input_file_from_path(photo_path) or {
					eprintln('cannot read ${photo_path}: ${err}')
					continue
				}
				raw := bot.http_request_files('sendPhoto', {
					'chat_id': msg.chat.id.str()
					'caption': 'Here you go!'
				}, {
					'photo': [photo]
				}) or {
					eprintln('sendPhoto failed: ${err}')
					continue
				}
				sent := json.decode(vgram.Message, raw) or { continue }
				eprintln('sent photo, message_id=${sent.message_id}')
			}
		}
	}
}
