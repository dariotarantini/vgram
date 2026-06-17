module main

import dariotarantini.vgram

fn main() {
	bot := vgram.new_bot('API_TOKEN')
	// `offset` is the id of the first update we still want. Advancing it past a
	// handled update confirms it, so Telegram won't redeliver it.
	mut offset := i64(0)
	for {
		// timeout:20 = long polling, so the loop blocks instead of busy-spinning
		// while idle. Skip this round on a transport/API error.
		updates := bot.get_updates(offset: offset, limit: 100, timeout: 20) or { continue }
		for update in updates {
			offset = update.update_id + 1
			// `message` is an optional reference (?&Message); unwrap it once,
			// then `from`/`chat` are plain values.
			if msg := update.message {
				if msg.text == '/start' {
					bot.send_chat_action(chat_id: msg.from.id.str(), action: 'typing') or {}
					bot.send_message(chat_id: msg.from.id.str(), text: 'Hi man') or {}
				}
			}
		}
	}
}
