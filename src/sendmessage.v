module hygram

import http
import json

// sendMessage
fn (u Telegram) send_message(chat_id int, text string) string {
    mut args := map[string]string{}
    args['chat_id'] = chat_id.str()
    args['text'] = text
    return u.raw_request('sendMessage', args)
}
