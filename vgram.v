module vgram

import http
import json


// main struct
struct Telegram {
pub:
    Token string
    Debug bool
}

pub fn new_bot(utoken string, udebug bool) Telegram {
    return Telegram{
        Token: utoken
        Debug: udebug
    }
}
pub fn (u Telegram) raw_request(method string, data map[string]string) string {
    mut post_data := ''

    for e in data.entries {
        k := e.key
        v := data[k]
        post_data += '$e.key=$v&'
    }
    url := 'https://api.telegram.org/bot'+u.Token+'/$method'
    if u.Debug == true {
        println('--- DEBUG ---')
        println('URL: $url')
        println('POST: $post_data')
        println('--- END ---')
    }
    return http.post(url, post_data)
}