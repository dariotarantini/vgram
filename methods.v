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
        println('URL: $url')
        println('POST: $data')
    }
    str_resp := http.post(url, data) or { 
        panic('failed to make http req')
        return ''
    }
    if d.debug == true {
        println('RESPONSE: $str_resp.text')
        println('--- END ---')
    }
    return str_resp.text
}
