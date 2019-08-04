module vgram

/*
 * Getting updates methods
*/
pub fn (d Bot) get_updates(e NewGetUpdates) []Update {
    x := d.http_request('getUpdates', json.encode(e))
    resp := json.decode(RespGetUpdates, x) or { 
        panic('Failed to decode json')
        return []Update{}
    }
    return resp.result
}


/*
 * Other methods
*/
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
pub fn (d Bot) forward_message(e NewForwardMessage) Message {
    x := d.http_request('forwardMessage', json.encode(e))
    resp := json.decode(RespForwardMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_photo(e NewSendPhoto) Message {
    x := d.http_request('sendPhoto', json.encode(e))
    resp := json.decode(RespSendPhoto, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_audio(e NewSendAudio) Message {
    x := d.http_request('sendAudio', json.encode(e))
    resp := json.decode(RespSendPhoto, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_document(e NewSendDocument) Message {
    x := d.http_request('sendDocument', json.encode(e))
    resp := json.decode(RespSendDocument, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}