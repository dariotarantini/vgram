module hygram

import http
import json


// main struct
struct Telegram {
    Token string
}


pub fn (u Telegram) raw_request(method string, dataa map[string]string) string {
    mut post_data := ''
    for key, value in dataa {
        post_data += '$key=$value&'
    }
    return http.post('https://api.telegram.org/bot{$u.Token}/{$method}', post_data)
}