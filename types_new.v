module vgram
// getUpdates
struct NewGetUpdates {
pub:
    offset int
    limit int
    timeout int
    allowed_updates []string
}
// sendMessage
struct NewSendMessage {
pub:
    chat_id string
    text string
    parse_mode string
    disable_web_page_preview bool
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// forwardMessage
struct NewForwardMessage {
pub:
    chat_id string
	from_chat_id string
	disable_notification bool
	message_id int
}
// sendPhoto
struct NewSendPhoto {
pub:
    chat_id string
	photo string
    caption string
    parse_mode string
    disable_web_page_preview bool
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendAudio
struct NewSendAudio {
pub:
    chat_id string
	audio string
    caption string
    parse_mode string
	performer string
	title string
	thumb string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendDocument
struct NewSendDocument {
pub:
    chat_id string
	document string
    caption string
    parse_mode string
	thumb string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendVideo
struct NewSendVideo {
pub:
    chat_id string
	video string
	duration int
	width int
	height int
	supports_streaming bool
    caption string
    parse_mode string
	thumb string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendAnimation
struct NewSendAnimation {
pub:
    chat_id string
	animation string
	duration int
	width int
	height int
    caption string
    parse_mode string
	thumb string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendVoice
struct NewSendVoice {
pub:
    chat_id string
	voice string
	duration int
    caption string
    parse_mode string
	thumb string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendVideoNote
struct NewSendVideoNote {
pub:
    chat_id string
	video_note string
	duration int
	length int
    caption string
    parse_mode string
	thumb string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendMediaGroup
struct NewSendMediaGroup {
pub:
    chat_id string
	media string // json of []InputMedia (not implemented)
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendLocation
struct NewSendLocation {
pub:
    chat_id string
	latitude f32
	longitude f32
	live_period int
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// editMessageLiveLocation
struct NewEditMessageLiveLocation {
pub:
    chat_id string
	message_id int
	inline_message_id string
	latitude f32
    longitude f32
    reply_markup string
}
// stopMessageLiveLocation
struct NewStopMessageLiveLocation {
pub:
    chat_id string
	message_id int
	inline_message_id string
    reply_markup string
}
// sendVenue
struct NewSendVenue {
pub:
    chat_id string
	latitude f32
    longitude  f32
    title string
    address string
    foursquare_id string
    foursquare_type string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendContact
struct NewSendContact {
pub:
    chat_id string
    phone_number string
    first_name string
    last_name string
    vcard string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendPoll
struct NewSendPoll {
pub:
    chat_id string
    question string
    options []string
    disable_notification bool
    reply_to_message_id int
    reply_markup string
}
// sendChatAction
struct NewSendChatAction {
pub:
    chat_id string
    action string
}
// getUserProfilePhotos
struct NewGetUserProfilePhotos {
pub:
    user_id int
    offset int
    limit int
}
