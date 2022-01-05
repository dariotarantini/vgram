module vgram

import net.http
import time
import json

[params]
pub struct ConfigBot {
pub:
    token string [required]
    endpoint string = "https://api.telegram.org/bot"
}

struct Bot {
    token string
    endpoint string
}

pub fn new_bot(conf ConfigBot) Bot {
    return Bot{
        token: conf.token
        endpoint: conf.endpoint
    }
}

pub struct ResponserOK {
pub:
	ok bool                
	result string [raw]          
}

pub struct ResponserNotOK {
pub:
	ok bool                
	error_code int                 
	description string              
}

fn (d Bot) http_request(method string, _data string) string {
    result := http.post_json("${d.endpoint}${d.token}/${method}", _data)  or {
        println("[ERROR] Unable to do request")
        return ""
    }
    if result.status_code == 200 {
        xtgresp := json.decode(ResponserOK, result.text) or { 
            println("[ERROR] Failed to decode json.")
            return ""
        }
    	return xtgresp.result
    } else {
        xtgresp := json.decode(ResponserNotOK, result.text) or { 
            println("[ERROR] Failed to decode json.")
            return ""
        }
        println("[ERROR] Method: ${method}\nTime: " + time.now().str() + "\nCode: " + xtgresp.error_code.str() + "\nDescription: " + xtgresp.description)
        return ""
    }
}
