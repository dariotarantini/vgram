module vgram

import http
import json

// getUpdates
struct fromMessage {
pub:
    id int
    is_bot bool
    first_name string
    last_name string
    username string
    language_code string
}
struct chatMessage {
pub:
    id int
    first_name string
    last_name string
    username string
    //type string
}
struct RespMessage {
pub:
    message_id int
    from fromMessage
    chat chatMessage
    date int
    text string
}
struct getUpdatesResp {
pub:
    update_id int
    message RespMessage
}
struct resultGetUpdates {
pub:
	ok bool
    result []getUpdatesResp
}
pub fn (u Telegram) get_updates(offset int) resultGetUpdates {
    mut args := map[string]string{}
    args['offset'] = offset.str()
    resp := json.decode(resultGetUpdates, u.raw_request('getUpdates', args)) or {
	    eprintln('Failed to decode json')
	    return resultGetUpdates{}
    }
    return resp
}