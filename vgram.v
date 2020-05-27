module vgram

import net.http
import time
import json

pub struct Bot {
pub:
    token string
}

pub fn new_bot(utoken string) Bot {
    return Bot{
        token: utoken
    }
}

fn (d Bot) http_request(method, _data string) string {
    _req := http.Request{
        method: "POST"
        headers: {
            'Content-Type': 'application/json'
        }
        cookies: map[string]string
        data: _data
        url: "https://api.telegram.org/bot${d.token}/${method}"
        user_agent: ""
        verbose: false
        user_ptr: 0
        ws_func: 0
    }
    result := _req.do() or {
        println("Unable to do request")
        return ""
    }
    if result.status_code == 200 {
        _tgresp := json.decode(ResponserOK, result.text) or { 
            println("Failed to decode json")
            return ""
        }
    	return _tgresp.result
    } else {
        _tgresp := json.decode(ResponserNotOK, result.text) or { 
            println("Failed to decode json")
            return ""
        }
        println("\n\nError!\nMethod: ${method}\nTime: " + time.now().str() + "\nData: ${_data}\nError code: " + _tgresp.error_code.str() + "\nDescription: " + _tgresp.description)
        return ""
    }
}
