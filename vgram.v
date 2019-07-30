module vgram

import http
import json

struct Bot {
    Token string
    Debug bool
}
pub fn new_bot(token string, debug bool) Bot {
    return Bot{
        Token: token
        Debug: debug
    }
}

fn (d Bot) http_request(data string) APIResponse {
    url := 'https://api.telegram.org/bot'+d.Token+'/'
    if d.Debug == true {
        println('--- DEBUG ---')
        println('POST: $data')
        println('--- END ---')
    }
    str_resp := http.post(url, data) or { 
        panic('failed to decode json')
        return APIResponse{}
    }
    result := json.decode(APIResponse, str_resp) or { 
        panic('failed to decode json')
        return APIResponse{}
    }
    return result
}
