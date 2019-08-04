module vgram

import http
import json

struct Bot {
    token string
    debug bool
}
    pub fn new_bot(utoken string, udebug bool) Bot {
    return Bot{
        token: utoken
        debug: udebug
    }
}

fn (d Bot) http_request(data string) ApiResponse {
    url := 'https://api.telegram.org/bot'+d.token+'/'
    if d.debug == true {
        println('--- DEBUG ---')
        println('POST: $data')
        println('--- END ---')
    }
    str_resp := http.post(url, data) or { 
        panic('failed to make http req')
        return ApiResponse{}
    }
    result := json.decode(ApiResponse, str_resp.text) or { 
        panic('failed to decode json')
        return ApiResponse{}
    }
    return result
}
