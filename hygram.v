module hygram

import http
import json


// main struct
pub struct Telegram {
pub:
    Token string
}


pub fn (u Telegram) raw_request(
    method string, 
    data map[string]string
    ) string {
    mut post_data := ''

    for e in data.entries {
        k := e.key
        v := data[k]
        post_data += '$e.key=$v&'
    }
    return http.post('https://api.telegram.org/bot{$u.Token}/{$method}', post_data)
}