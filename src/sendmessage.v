module hygram

import http
import json

// sendMessage
fn (u Telegram) send_message(chat_id int, text string) string {
    return u.raw_request('sendMessage', {
        'chat_id' : chat_id,
        'text' : text
    })
}
