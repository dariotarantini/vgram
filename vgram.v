module vgram

import net.http
import time

pub struct Bot {
pub:
    token string
}

pub fn new_bot(utoken string) Bot {
    return Bot{
        token: utoken
    }
}

fn (d Bot) http_request(method, data string) ?string {
    url := "https://api.telegram.org/bot${d.token}/${method}"
    mut req := http.new_request('POST', url, data) or { 
        return error("Unable to init request")
    }
    req.add_header('Content-Type', 'application/json')
    result := req.do() or {
        return error("Unable to do request")
    }
    resp := json.decode(Responser, result.text) or { 
        return error("Failed to decode json")
    }    
	return resp.result
}
