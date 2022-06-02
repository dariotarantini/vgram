module vgram

import net.http
import time
import json

pub struct Bot {
pub:
    token string
    endpoint string = "https://api.telegram.org/bot"
}

pub fn new_bot(utoken string) Bot {
    return Bot{
        token: utoken
    }
}

fn (d Bot) http_request(method string, _data string) string {
    result := http.post_json("${d.endpoint}${d.token}/${method}", _data)  or {
        println("Unable to do request")
        return ""
    }
    if result.status_code == 200 {
        xtgresp := json.decode(ResponserOK, result.body) or { 
            println("Failed to decode json")
            return ""
        }
    	return xtgresp.result
    } else {
        xtgresp := json.decode(ResponserNotOK, result.body) or { 
            println("Failed to decode json")
            return ""
        }
        println("\n\nError!\nMethod: ${method}\nTime: " + time.now().str() + "\nError code: " + xtgresp.error_code.str() + "\nDescription: " + xtgresp.description)
        return ""
    }
}
