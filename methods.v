module vgram

/*
 * Getting updates methods
*/
pub fn (d Bot) get_updates(e NewGetUpdates) []Update {
    x := d.http_request('getUpdates', json.encode(e))
    resp := json.decode(RespUpdates, x) or { 
        panic('Failed to decode json')
        return []Update{}
    }
    return resp.result
}


/*
 * Other methods
*/
pub fn (d Bot) get_me() User {
    resp := json.decode(RespUser, d.http_request('getMe', '')) or { 
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
pub fn (d Bot) send_video(e NewSendVideo) Message {
    x := d.http_request('sendVideo', json.encode(e))
    resp := json.decode(RespSendVideo, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_animation(e NewSendAnimation) Message {
    x := d.http_request('sendAnimation', json.encode(e))
    resp := json.decode(RespSendAnimation, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_voice(e NewSendVoice) Message {
    x := d.http_request('sendVoice', json.encode(e))
    resp := json.decode(RespSendVoice, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_video_note(e NewSendVideoNote) Message {
    x := d.http_request('sendVideoNote', json.encode(e))
    resp := json.decode(RespSendVideoNote, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_media_group(e NewSendMediaGroup) Message {
    x := d.http_request('sendMediaGroup', json.encode(e))
    resp := json.decode(RespSendMediaGroup, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_location(e NewSendLocation) Message {
    x := d.http_request('sendLocation', json.encode(e))
    resp := json.decode(RespSendLocation, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) edit_message_live_location(e NewEditMessageLiveLocation) Message {
    x := d.http_request('editMessageLiveLocation', json.encode(e))
    resp := json.decode(RespEditMessageLiveLocation, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) stop_message_live_location(e NewStopMessageLiveLocation) Message {
    x := d.http_request('stopMessageLiveLocation', json.encode(e))
    resp := json.decode(RespStopMessageLiveLocation, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
