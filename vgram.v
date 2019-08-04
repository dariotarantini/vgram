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

fn (d Bot) http_request(method, data string) string {
    url := 'https://api.telegram.org/bot'+d.token+'/'+method
    if d.debug == true {
        println('--- DEBUG ---')
        println('POST: $data')
    }
    result := http.post(url, data) or { 
        panic('failed to make http req')
        return ''
    }
    return result.text
}
