module vgram


pub fn (d Bot) get_updates(e NewGetUpdates) []Update {
    x := d.http_request('getUpdates', json.encode(e))
    resp := json.decode(RespUpdates, x) or { 
        panic('Failed to decode json')
        return [Update{}]
    }
    return resp.result
}
pub fn (d Bot) get_me() User {
    resp := json.decode(RespUser, d.http_request('getMe', '')) or { 
        panic('Failed to decode json')
        return User{}
    }
    return resp.result
}
pub fn (d Bot) send_message(e NewSendMessage) Message {
    x := d.http_request('sendMessage', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) forward_message(e NewForwardMessage) Message {
    x := d.http_request('forwardMessage', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_photo(e NewSendPhoto) Message {
    x := d.http_request('sendPhoto', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_audio(e NewSendAudio) Message {
    x := d.http_request('sendAudio', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_document(e NewSendDocument) Message {
    x := d.http_request('sendDocument', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_video(e NewSendVideo) Message {
    x := d.http_request('sendVideo', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_animation(e NewSendAnimation) Message {
    x := d.http_request('sendAnimation', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_voice(e NewSendVoice) Message {
    x := d.http_request('sendVoice', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_video_note(e NewSendVideoNote) Message {
    x := d.http_request('sendVideoNote', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_media_group(e NewSendMediaGroup) Message {
    x := d.http_request('sendMediaGroup', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_location(e NewSendLocation) Message {
    x := d.http_request('sendLocation', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) edit_message_live_location(e NewEditMessageLiveLocation) Message {
    x := d.http_request('editMessageLiveLocation', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) stop_message_live_location(e NewStopMessageLiveLocation) Message {
    x := d.http_request('stopMessageLiveLocation', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_venue(e NewSendVenue) Message {
    x := d.http_request('sendVenue', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_contact(e NewSendContact) Message {
    x := d.http_request('sendContact', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_poll(e NewSendPoll) Message {
    x := d.http_request('sendPoll', json.encode(e))
    resp := json.decode(RespMessage, x) or { 
        panic('Failed to decode json')
        return Message{}
    }
    return resp.result
}
pub fn (d Bot) send_chat_action(e NewSendChatAction) bool {
    x := d.http_request('sendChatAction', json.encode(e))
    resp := json.decode(RespBool, x) or { 
        panic('Failed to decode json')
        return false
    }
    return resp.result
}
pub fn (d Bot) get_user_profile_photos(e NewGetUserProfilePhotos) UserProfilePhotos {
    x := d.http_request('getUserProfilePhotos', json.encode(e))
    resp := json.decode(RespUserProfilePhotos, x) or { 
        panic('Failed to decode json')
        return UserProfilePhotos{}
    }
    return resp.result
}
pub fn (d Bot) get_file(e NewGetFile) File {
    x := d.http_request('getFile', json.encode(e))
    resp := json.decode(RespFile, x) or { 
        panic('Failed to decode json')
        return File{}
    }
    return resp.result
}
pub fn (d Bot) answer_inline_query(e NewAnswerInlineQuery) bool {
    x := d.http_request('answerInlineQuery', json.encode(e))
    resp := json.decode(RespBool, x) or { 
        panic('Failed to decode json')
        return false
    }
    return resp.result
}
