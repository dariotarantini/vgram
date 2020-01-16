module vgram

import json

pub struct NewGetUpdates {
pub:
    offset int
    limit int
    timeout int
    allowed_updates []string
}
pub fn (d Bot) get_updates(e NewGetUpdates) ?[]Update {
    x := d.http_request('getUpdates', json.encode(e)) or {
		return error(err)
	}
    resp := json.decode([]Update, x) or {
		return error("Failed to decode json")
    }
    return resp
}
pub fn (d Bot) get_me() ?User {
    x := d.http_request('getMe', '') or {
		return error(err)
	}
    resp := json.decode(User, x) or {
		return error("Failed to decode json")
    }
    return resp
}

// --
pub struct NewSendMessage {
pub:
    chat_id string
    text string
    parse_mode string
    disable_web_page_preview bool
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
pub fn (d Bot) send_message(e NewSendMessage) ?Message {
    x := d.http_request('sendMessage', json.encode(e)) or {
		return error(err)
	}
    resp := json.decode(Message, x) or {
		return error("Failed to decode json")
    }
    return resp
}