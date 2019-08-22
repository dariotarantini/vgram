module vgram

import http
import json
import time

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
        println('[debug] - ${time.now().uni}')
        println('request:\nurl: $url\npost data:$data\n')
    }

    mut req := http.new_request('POST', url, data) or { 
        if d.debug == true {
            println('PANIC! http request failed!')
            println('[debug] - end\n\n')
        }
        return ''
    }
    req.add_header('Content-Type', 'application/json')
    result := req.do() or {
        return ''
    }
    if d.debug == true {
        println('response:\nstatus code: ${result.status_code}\ntext: ${result.text}')
        println('[debug] - end\n\n')
    }
    return result.text
}
