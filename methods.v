module vgram

pub fn (d Bot) get_updates(e NewGetUpdates) []Update {
    x := d.http_request('getUpdates', json.encode(e))
    resp := json.decode(RespGetUpdates, x) or { 
        panic('Failed to decode json')
        return []Update{}
    }
    return resp.result
}

pub fn (d Bot) get_me() User {
    resp := json.decode(RespGetMe, d.http_request('getMe', '')) or { 
        panic('Failed to decode json')
        return User{}
    }
    return resp.result
}

pub fn (d Bot) send_message(e NewSendMessage) Message {
    x := d.http_request('sendMessage', json.encode(e))
    resp := json.decode(RespSendMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
