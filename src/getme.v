module hygram

import http
import json

struct getMeResp {
mut:
    id int
    is_bot bool
    first_name string
    username string
}

struct resultGetMe {
mut:
    ok bool
    result getMeResp
}
pub fn (u Telegram) get_me(offset int) resultGetUpdates {
    resp := json.decode(resultGetMe, u.raw_request('getMe', {})) or {
	    eprintln('Failed to decode json')
	    return resultGetUpdates{}
    }
    return resp
}