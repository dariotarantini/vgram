module vgram

pub fn (d Bot) get_updates(e NewGetUpdates) Update {
    e.method = 'getUpdates'
    resp := d.http_request(json.encode(e))
    result := json.decode(Update, resp.result) or { 
        panic('Failed to decode json')
        return Update{}
    }
    return result
}
pub fn (d Bot) get_me(e NewGetMe) User {
    e.method = 'getMe'
    resp := d.http_request(json.encode(e))
    result := json.decode(User, resp.result) or { 
        panic('Failed to decode json')
        return User{}
    }
    return result
}
pub fn (d Bot) send_message(e NewSendMessage) Message {
    e.method = 'sendMessage'
    resp := d.http_request(json.encode(e))
    result := json.decode(Message, resp.result) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return result
}
