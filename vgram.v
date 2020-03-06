module vgram

import net.http

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
    req := http.Request{
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
    result := req.do() or {
        println("Unable to do request")
        return ""
    }
    resp := json.decode(Responser, result.text) or { 
        println("Failed to decode json")
        return ""
    }    
	return resp.result
}
