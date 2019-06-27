module hygram

import http
import json

// getUpdates
struct fromMessage {
    id int
    is_bot bool
    first_name string
    last_name string
    username string
    language_code string
}
struct chatMessage {
    id int
    first_name string
    last_name string
    username string
    //type string
}
struct RespMessage {
    message_id int
    from fromMessage
    chat chatMessage
    date int
    text string
}
struct getUpdatesResp {
    update_id int
    message RespMessage
}
struct resultGetUpdates {
	ok bool
    result []getUpdatesResp
}
pub fn (u Telegram) get_updates(offset int) resultGetUpdates {
    resp := json.decode(resultGetUpdates, u.raw_request('getUpdates', {
        'offset' : offset.str()
    })) or {
	    eprintln('Failed to decode json')
	    return resultGetUpdates{}
    }
    return resp
}