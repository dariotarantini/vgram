module vgram

import json
 
pub struct NewGetUpdates {
pub:
	offset int //Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers of previously received updates. By default, updates starting with the earliest unconfirmed update are returned. An update is considered confirmed as soon as getUpdates is called with an offset higher than its update_id. The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue. All previous updates will forgotten.
	limit int //Limits the number of updates to be retrieved. Values between 1—100 are accepted. Defaults to 100.
	timeout int //Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.
	allowed_updates []string //List the types of updates you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all updates regardless of type (default). If not specified, the previous setting will be used.Please note that this parameter doesn't affect updates created before the call to the getUpdates, so unwanted updates may be received for a short period of time.
}
// get_updates Use this method to receive incoming updates using long polling (wiki). An Array of Update objects is returned.
pub fn (d Bot) get_updates(e NewGetUpdates) []Update {
    x := d.http_request("getUpdates", json.encode(e))
    resp := json.decode([]Update, x) or {
        return [Update{}]
    }
    return resp
}

pub struct NewSetWebhook {
pub:
	url string //HTTPS url to send updates to. Use an empty string to remove webhook integration
	certificate string //Upload your public key certificate so that the root certificate in use can be checked. See our self-signed guide for details.
	max_connections int //Maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit the load on your bot‘s server, and higher values to increase your bot’s throughput.
	allowed_updates []string //List the types of updates you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all updates regardless of type (default). If not specified, the previous setting will be used.Please note that this parameter doesn't affect updates created before the call to the setWebhook, so unwanted updates may be received for a short period of time.
}
// set_webhook Use this method to specify a url and receive incoming updates via an outgoing webhook. Whenever there is an update for the bot, we will send an HTTPS POST request to the specified url, containing a JSON-serialized Update. In case of an unsuccessful request, we will give up after a reasonable amount of attempts. Returns True on success.
pub fn (d Bot) set_webhook(e NewSetWebhook) bool {
    x := d.http_request("setWebhook", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewDeleteWebhook {
pub:
	url string //
	has_custom_certificate bool //
	pending_update_count int //
	last_error_date int //
	last_error_message string //
	max_connections int //
	allowed_updates []string //
}
// delete_webhook Use this method to remove webhook integration if you decide to switch back to getUpdates. Returns True on success. Requires no parameters.
pub fn (d Bot) delete_webhook(e NewDeleteWebhook) bool {
    x := d.http_request("deleteWebhook", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewGetWebhookInfo {
pub:
	url string //
	has_custom_certificate bool //
	pending_update_count int //
	last_error_date int //
	last_error_message string //
	max_connections int //
	allowed_updates []string //
}
// get_webhook_info Use this method to get current webhook status. Requires no parameters. On success, returns a WebhookInfo object. If the bot is using getUpdates, will return an object with the url field empty.
pub fn (d Bot) get_webhook_info(e NewGetWebhookInfo) WebhookInfo {
    x := d.http_request("getWebhookInfo", json.encode(e))
    resp := json.decode(WebhookInfo, x) or {
        return WebhookInfo{}
    }
    return resp
}

pub struct NewGetMe {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	text string //Text of the message to be sent
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
	disable_web_page_preview bool //Disables link previews for links in this message
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// get_me A simple method for testing your bot&#39;s auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
pub fn (d Bot) get_me(e NewGetMe) User {
    x := d.http_request("getMe", json.encode(e))
    resp := json.decode(User, x) or {
        return User{}
    }
    return resp
}

pub struct NewSendMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	text string //Text of the message to be sent
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
	disable_web_page_preview bool //Disables link previews for links in this message
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_message Use this method to send text messages. On success, the sent Message is returned.
pub fn (d Bot) send_message(e NewSendMessage) Message {
    x := d.http_request("sendMessage", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewForwardMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	from_chat_id string //Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	message_id int //Message identifier in the chat specified in from_chat_id
}
// forward_message Use this method to forward messages of any kind. On success, the sent Message is returned.
pub fn (d Bot) forward_message(e NewForwardMessage) Message {
    x := d.http_request("forwardMessage", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendPhoto {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	photo string //Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. More info on Sending Files »
	caption string //Photo caption (may also be used when resending photos by file_id), 0-1024 characters
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_photo Use this method to send photos. On success, the sent Message is returned.
pub fn (d Bot) send_photo(e NewSendPhoto) Message {
    x := d.http_request("sendPhoto", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendAudio {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	audio string //Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	caption string //Audio caption, 0-1024 characters
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	duration int //Duration of the audio in seconds
	performer string //Performer
	title string //Track name
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_audio Use this method to send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .mp3 format. On success, the sent Message is returned. Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.
pub fn (d Bot) send_audio(e NewSendAudio) Message {
    x := d.http_request("sendAudio", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendDocument {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	document string //File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string //Document caption (may also be used when resending documents by file_id), 0-1024 characters
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_document Use this method to send general files. On success, the sent Message is returned. Bots can currently send files of any type of up to 50 MB in size, this limit may be changed in the future.
pub fn (d Bot) send_document(e NewSendDocument) Message {
    x := d.http_request("sendDocument", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendVideo {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	video string //Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data. More info on Sending Files »
	duration int //Duration of sent video in seconds
	width int //Video width
	height int //Video height
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string //Video caption (may also be used when resending videos by file_id), 0-1024 characters
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	supports_streaming bool //Pass True, if the uploaded video is suitable for streaming
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_video Use this method to send video files, Telegram clients support mp4 videos (other formats may be sent as Document). On success, the sent Message is returned. Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.
pub fn (d Bot) send_video(e NewSendVideo) Message {
    x := d.http_request("sendVideo", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendAnimation {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	animation string //Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More info on Sending Files »
	duration int //Duration of sent animation in seconds
	width int //Animation width
	height int //Animation height
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string //Animation caption (may also be used when resending animation by file_id), 0-1024 characters
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_animation Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound). On success, the sent Message is returned. Bots can currently send animation files of up to 50 MB in size, this limit may be changed in the future.
pub fn (d Bot) send_animation(e NewSendAnimation) Message {
    x := d.http_request("sendAnimation", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendVoice {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	voice string //Audio file to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	caption string //Voice message caption, 0-1024 characters
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	duration int //Duration of the voice message in seconds
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_voice Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document). On success, the sent Message is returned. Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.
pub fn (d Bot) send_voice(e NewSendVoice) Message {
    x := d.http_request("sendVoice", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendVideoNote {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	video_note string //Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers (recommended) or upload a new video using multipart/form-data. More info on Sending Files ». Sending video notes by a URL is currently unsupported
	duration int //Duration of sent video in seconds
	length int //Video width and height, i.e. diameter of the video message
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_video_note As of v.4.0, Telegram clients support rounded square mp4 videos of up to 1 minute long. Use this method to send video messages. On success, the sent Message is returned.
pub fn (d Bot) send_video_note(e NewSendVideoNote) Message {
    x := d.http_request("sendVideoNote", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendMediaGroup {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	media [] InputMediaPhoto and InputMediaVideo //A JSON-serialized array describing photos and videos to be sent, must include 2–10 items
	disable_notification bool //Sends the messages silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the messages are a reply, ID of the original message
}
// send_media_group Use this method to send a group of photos or videos as an album. On success, an array of the sent Messages is returned.
pub fn (d Bot) send_media_group(e NewSendMediaGroup) []Message {
    x := d.http_request("sendMediaGroup", json.encode(e))
    resp := json.decode([]Message, x) or {
        return [Message{}]
    }
    return resp
}

pub struct NewSendLocation {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	latitude f32 //Latitude of the location
	longitude f32 //Longitude of the location
	live_period int //Period in seconds for which the location will be updated (see Live Locations, should be between 60 and 86400.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_location Use this method to send point on the map. On success, the sent Message is returned.
pub fn (d Bot) send_location(e NewSendLocation) Message {
    x := d.http_request("sendLocation", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewEditMessageLiveLocation {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	latitude f32 //Latitude of new location
	longitude f32 //Longitude of new location
	reply_markup string //A JSON-serialized object for a new inline keyboard.
}
// edit_message_live_location Use this method to edit live location messages. A location can be edited until its live_period expires or editing is explicitly disabled by a call to stopMessageLiveLocation. On success, if the edited message was sent by the bot, the edited Message is returned, otherwise True is returned.
pub fn (d Bot) edit_message_live_location(e NewEditMessageLiveLocation) Message {
    x := d.http_request("editMessageLiveLocation", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewStopMessageLiveLocation {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message with live location to stop
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	reply_markup string //A JSON-serialized object for a new inline keyboard.
}
// stop_message_live_location Use this method to stop updating a live location message before live_period expires. On success, if the message was sent by the bot, the sent Message is returned, otherwise True is returned.
pub fn (d Bot) stop_message_live_location(e NewStopMessageLiveLocation) Message {
    x := d.http_request("stopMessageLiveLocation", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendVenue {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	latitude f32 //Latitude of the venue
	longitude f32 //Longitude of the venue
	title string //Name of the venue
	address string //Address of the venue
	foursquare_id string //Foursquare identifier of the venue
	foursquare_type string //Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_venue Use this method to send information about a venue. On success, the sent Message is returned.
pub fn (d Bot) send_venue(e NewSendVenue) Message {
    x := d.http_request("sendVenue", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendContact {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	phone_number string //Contact's phone number
	first_name string //Contact's first name
	last_name string //Contact's last name
	vcard string //Additional data about the contact in the form of a vCard, 0-2048 bytes
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove keyboard or to force a reply from the user.
}
// send_contact Use this method to send phone contacts. On success, the sent Message is returned.
pub fn (d Bot) send_contact(e NewSendContact) Message {
    x := d.http_request("sendContact", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendPoll {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername). A native poll can't be sent to a private chat.
	question string //Poll question, 1-255 characters
	options []string //List of answer options, 2-10 strings 1-100 characters each
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_poll Use this method to send a native poll. A native poll can&#39;t be sent to a private chat. On success, the sent Message is returned.
pub fn (d Bot) send_poll(e NewSendPoll) Message {
    x := d.http_request("sendPoll", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSendChatAction {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	action string //Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data, record_video_note or upload_video_note for video notes.
}
// send_chat_action Use this method when you need to tell the user that something is happening on the bot&#39;s side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success.
pub fn (d Bot) send_chat_action(e NewSendChatAction) {
    d.http_request("sendChatAction", json.encode(e))
}

pub struct NewGetUserProfilePhotos {
pub:
	user_id int //Unique identifier of the target user
	offset int //Sequential number of the first photo to be returned. By default, all photos are returned.
	limit int //Limits the number of photos to be retrieved. Values between 1—100 are accepted. Defaults to 100.
}
// get_user_profile_photos Use this method to get a list of profile pictures for a user. Returns a UserProfilePhotos object.
pub fn (d Bot) get_user_profile_photos(e NewGetUserProfilePhotos) UserProfilePhotos {
    x := d.http_request("getUserProfilePhotos", json.encode(e))
    resp := json.decode(UserProfilePhotos, x) or {
        return UserProfilePhotos{}
    }
    return resp
}

pub struct NewGetFile {
pub:
	file_id string //File identifier to get info about
}
// get_file Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a File object is returned. The file can then be downloaded via the link https://api.telegram.org/file/bot&lt;token&gt;/&lt;file_path&gt;, where &lt;file_path&gt; is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile again.
pub fn (d Bot) get_file(e NewGetFile) File {
    x := d.http_request("getFile", json.encode(e))
    resp := json.decode(File, x) or {
        return File{}
    }
    return resp
}

pub struct NewKickChatMember {
pub:
	chat_id string //Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)
	user_id int //Unique identifier of the target user
	until_date int //Date when the user will be unbanned, unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever
}
// kick_chat_member Use this method to kick a user from a group, a supergroup or a channel. In the case of supergroups and channels, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub fn (d Bot) kick_chat_member(e NewKickChatMember) bool {
    x := d.http_request("kickChatMember", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewUnbanChatMember {
pub:
	chat_id string //Unique identifier for the target group or username of the target supergroup or channel (in the format @username)
	user_id int //Unique identifier of the target user
}
// unban_chat_member Use this method to unban a previously kicked user in a supergroup or channel. The user will not return to the group or channel automatically, but will be able to join via link, etc. The bot must be an administrator for this to work. Returns True on success.
pub fn (d Bot) unban_chat_member(e NewUnbanChatMember) bool {
    x := d.http_request("unbanChatMember", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewRestrictChatMember {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	user_id int //Unique identifier of the target user
	permissions ChatPermissions //New user permissions
	until_date int //Date when restrictions will be lifted for the user, unix time. If user is restricted for more than 366 days or less than 30 seconds from the current time, they are considered to be restricted forever
}
// restrict_chat_member Use this method to restrict a user in a supergroup. The bot must be an administrator in the supergroup for this to work and must have the appropriate admin rights. Pass True for all permissions to lift restrictions from a user. Returns True on success.
pub fn (d Bot) restrict_chat_member(e NewRestrictChatMember) bool {
    x := d.http_request("restrictChatMember", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewPromoteChatMember {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	user_id int //Unique identifier of the target user
	can_change_info bool //Pass True, if the administrator can change chat title, photo and other settings
	can_post_messages bool //Pass True, if the administrator can create channel posts, channels only
	can_edit_messages bool //Pass True, if the administrator can edit messages of other users and can pin messages, channels only
	can_delete_messages bool //Pass True, if the administrator can delete messages of other users
	can_invite_users bool //Pass True, if the administrator can invite new users to the chat
	can_restrict_members bool //Pass True, if the administrator can restrict, ban or unban chat members
	can_pin_messages bool //Pass True, if the administrator can pin messages, supergroups only
	can_promote_members bool //Pass True, if the administrator can add new administrators with a subset of his own privileges or demote administrators that he has promoted, directly or indirectly (promoted by administrators that were appointed by him)
}
// promote_chat_member Use this method to promote or demote a user in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Pass False for all boolean parameters to demote a user. Returns True on success.
pub fn (d Bot) promote_chat_member(e NewPromoteChatMember) bool {
    x := d.http_request("promoteChatMember", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSetChatPermissions {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	permissions ChatPermissions //New default chat permissions
}
// set_chat_permissions Use this method to set default chat permissions for all members. The bot must be an administrator in the group or a supergroup for this to work and must have the can_restrict_members admin rights. Returns True on success.
pub fn (d Bot) set_chat_permissions(e NewSetChatPermissions) bool {
    x := d.http_request("setChatPermissions", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewExportChatInviteLink {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
}
// export_chat_invite_link Use this method to generate a new invite link for a chat; any previously generated link is revoked. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns the new invite link as String on success.
pub fn (d Bot) export_chat_invite_link(e NewExportChatInviteLink) string {
    x := d.http_request("exportChatInviteLink", json.encode(e))
    return x
}

pub struct NewSetChatPhoto {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	photo string //New chat photo, uploaded using multipart/form-data
}
// set_chat_photo Use this method to set a new profile photo for the chat. Photos can&#39;t be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub fn (d Bot) set_chat_photo(e NewSetChatPhoto) bool {
    x := d.http_request("setChatPhoto", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewDeleteChatPhoto {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
}
// delete_chat_photo Use this method to delete a chat photo. Photos can&#39;t be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub fn (d Bot) delete_chat_photo(e NewDeleteChatPhoto) bool {
    x := d.http_request("deleteChatPhoto", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSetChatTitle {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	title string //New chat title, 1-255 characters
}
// set_chat_title Use this method to change the title of a chat. Titles can&#39;t be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub fn (d Bot) set_chat_title(e NewSetChatTitle) bool {
    x := d.http_request("setChatTitle", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSetChatDescription {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	description string //New chat description, 0-255 characters
}
// set_chat_description Use this method to change the description of a group, a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub fn (d Bot) set_chat_description(e NewSetChatDescription) bool {
    x := d.http_request("setChatDescription", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewPinChatMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Identifier of a message to pin
	disable_notification bool //Pass True, if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels.
}
// pin_chat_message Use this method to pin a message in a group, a supergroup, or a channel. The bot must be an administrator in the chat for this to work and must have the ‘can_pin_messages’ admin right in the supergroup or ‘can_edit_messages’ admin right in the channel. Returns True on success.
pub fn (d Bot) pin_chat_message(e NewPinChatMessage) bool {
    x := d.http_request("pinChatMessage", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewUnpinChatMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
}
// unpin_chat_message Use this method to unpin a message in a group, a supergroup, or a channel. The bot must be an administrator in the chat for this to work and must have the ‘can_pin_messages’ admin right in the supergroup or ‘can_edit_messages’ admin right in the channel. Returns True on success.
pub fn (d Bot) unpin_chat_message(e NewUnpinChatMessage) bool {
    x := d.http_request("unpinChatMessage", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewLeaveChat {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
// leave_chat Use this method for your bot to leave a group, supergroup or channel. Returns True on success.
pub fn (d Bot) leave_chat(e NewLeaveChat) bool {
    x := d.http_request("leaveChat", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewGetChat {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
// get_chat Use this method to get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Returns a Chat object on success.
pub fn (d Bot) get_chat(e NewGetChat) Chat {
    x := d.http_request("getChat", json.encode(e))
    resp := json.decode(Chat, x) or {
        return Chat{}
    }
    return resp
}

pub struct NewGetChatAdministrators {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
// get_chat_administrators Use this method to get a list of administrators in a chat. On success, returns an Array of ChatMember objects that contains information about all chat administrators except other bots. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned.
pub fn (d Bot) get_chat_administrators(e NewGetChatAdministrators) []ChatMember {
    x := d.http_request("getChatAdministrators", json.encode(e))
    resp := json.decode([]ChatMember, x) or {
        return [ChatMember{}]
    }
    return resp
}

pub struct NewGetChatMembersCount {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
// get_chat_members_count Use this method to get the number of members in a chat. Returns Int on success.
pub fn (d Bot) get_chat_members_count(e NewGetChatMembersCount) string {
    x := d.http_request("getChatMembersCount", json.encode(e))
    return x
}

pub struct NewGetChatMember {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
	user_id int //Unique identifier of the target user
}
// get_chat_member Use this method to get information about a member of a chat. Returns a ChatMember object on success.
pub fn (d Bot) get_chat_member(e NewGetChatMember) ChatMember {
    x := d.http_request("getChatMember", json.encode(e))
    resp := json.decode(ChatMember, x) or {
        return ChatMember{}
    }
    return resp
}

pub struct NewSetChatStickerSet {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	sticker_set_name string //Name of the sticker set to be set as the group sticker set
}
// set_chat_sticker_set Use this method to set a new group sticker set for a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.
pub fn (d Bot) set_chat_sticker_set(e NewSetChatStickerSet) bool {
    x := d.http_request("setChatStickerSet", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewDeleteChatStickerSet {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
}
// delete_chat_sticker_set Use this method to delete a group sticker set from a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.
pub fn (d Bot) delete_chat_sticker_set(e NewDeleteChatStickerSet) bool {
    x := d.http_request("deleteChatStickerSet", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewAnswerCallbackQuery {
pub:
	callback_query_id string //Unique identifier for the query to be answered
	text string //Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters
	show_alert bool //If true, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.
	url string //URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @Botfather, specify the URL that opens your game – note that this will only work if the query comes from a callback_game button.Otherwise, you may use links like t.me/your_bot?start=XXXX that open your bot with a parameter.
	cache_time int //The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.
}
// answer_callback_query Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.
pub fn (d Bot) answer_callback_query(e NewAnswerCallbackQuery) bool {
    x := d.http_request("answerCallbackQuery", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewEditMessageText {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	text string //New text of the message
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
	disable_web_page_preview bool //Disables link previews for links in this message
	reply_markup string //A JSON-serialized object for an inline keyboard.
}
// edit_message_text Use this method to edit text and game messages. On success, if edited message is sent by the bot, the edited Message is returned, otherwise True is returned.
pub fn (d Bot) edit_message_text(e NewEditMessageText) Message {
    x := d.http_request("editMessageText", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewEditMessageCaption {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	caption string //New caption of the message
	parse_mode string //Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup string //A JSON-serialized object for an inline keyboard.
}
// edit_message_caption Use this method to edit captions of messages. On success, if edited message is sent by the bot, the edited Message is returned, otherwise True is returned.
pub fn (d Bot) edit_message_caption(e NewEditMessageCaption) Message {
    x := d.http_request("editMessageCaption", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewEditMessageMedia {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	media InputMedia //A JSON-serialized object for a new media content of the message
	reply_markup string //A JSON-serialized object for a new inline keyboard.
}
// edit_message_media Use this method to edit animation, audio, document, photo, or video messages. If a message is a part of a message album, then it can be edited only to a photo or a video. Otherwise, message type can be changed arbitrarily. When inline message is edited, new file can&#39;t be uploaded. Use previously uploaded file via its file_id or specify a URL. On success, if the edited message was sent by the bot, the edited Message is returned, otherwise True is returned.
pub fn (d Bot) edit_message_media(e NewEditMessageMedia) Message {
    x := d.http_request("editMessageMedia", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewEditMessageReplyMarkup {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	reply_markup string //A JSON-serialized object for an inline keyboard.
}
// edit_message_reply_markup Use this method to edit only the reply markup of messages. On success, if edited message is sent by the bot, the edited Message is returned, otherwise True is returned.
pub fn (d Bot) edit_message_reply_markup(e NewEditMessageReplyMarkup) Message {
    x := d.http_request("editMessageReplyMarkup", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewStopPoll {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Identifier of the original message with the poll
	reply_markup string //A JSON-serialized object for a new message inline keyboard.
}
// stop_poll Use this method to stop a poll which was sent by the bot. On success, the stopped Poll with the final results is returned.
pub fn (d Bot) stop_poll(e NewStopPoll) Poll {
    x := d.http_request("stopPoll", json.encode(e))
    resp := json.decode(Poll, x) or {
        return Poll{}
    }
    return resp
}

pub struct NewDeleteMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Identifier of the message to delete
}
// delete_message Use this method to delete a message, including service messages, with the following limitations:- A message can only be deleted if it was sent less than 48 hours ago.- Bots can delete outgoing messages in private chats, groups, and supergroups.- Bots can delete incoming messages in private chats.- Bots granted can_post_messages permissions can delete outgoing messages in channels.- If the bot is an administrator of a group, it can delete any message there.- If the bot has can_delete_messages permission in a supergroup or a channel, it can delete any message there.Returns True on success.
pub fn (d Bot) delete_message(e NewDeleteMessage) bool {
    x := d.http_request("deleteMessage", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSendSticker {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	sticker string //Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .webp file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
// send_sticker Use this method to send static .WEBP or animated .TGS stickers. On success, the sent Message is returned.
pub fn (d Bot) send_sticker(e NewSendSticker) Message {
    x := d.http_request("sendSticker", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewGetStickerSet {
pub:
	name string //Name of the sticker set
}
// get_sticker_set Use this method to get a sticker set. On success, a StickerSet object is returned.
pub fn (d Bot) get_sticker_set(e NewGetStickerSet) StickerSet {
    x := d.http_request("getStickerSet", json.encode(e))
    resp := json.decode(StickerSet, x) or {
        return StickerSet{}
    }
    return resp
}

pub struct NewUploadStickerFile {
pub:
	user_id int //User identifier of sticker file owner
	png_sticker string //Png image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. More info on Sending Files »
}
// upload_sticker_file Use this method to upload a .png file with a sticker for later use in createNewStickerSet and addStickerToSet methods (can be used multiple times). Returns the uploaded File on success.
pub fn (d Bot) upload_sticker_file(e NewUploadStickerFile) File {
    x := d.http_request("uploadStickerFile", json.encode(e))
    resp := json.decode(File, x) or {
        return File{}
    }
    return resp
}

pub struct NewCreateNewStickerSet {
pub:
	user_id int //User identifier of created sticker set owner
	name string //Short name of sticker set, to be used in t.me/addstickers/ URLs (e.g., animals). Can contain only english letters, digits and underscores. Must begin with a letter, can't contain consecutive underscores and must end in “_by_<bot username>”. <bot_username> is case insensitive. 1-64 characters.
	title string //Sticker set title, 1-64 characters
	png_sticker string //Png image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	emojis string //One or more emoji corresponding to the sticker
	contains_masks bool //Pass True, if a set of mask stickers should be created
	mask_position MaskPosition //A JSON-serialized object for position where the mask should be placed on faces
}
// create_new_sticker_set Use this method to create new sticker set owned by a user. The bot will be able to edit the created sticker set. Returns True on success.
pub fn (d Bot) create_new_sticker_set(e NewCreateNewStickerSet) bool {
    x := d.http_request("createNewStickerSet", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewAddStickerToSet {
pub:
	user_id int //User identifier of sticker set owner
	name string //Sticker set name
	png_sticker string //Png image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	emojis string //One or more emoji corresponding to the sticker
	mask_position MaskPosition //A JSON-serialized object for position where the mask should be placed on faces
}
// add_sticker_to_set Use this method to add a new sticker to a set created by the bot. Returns True on success.
pub fn (d Bot) add_sticker_to_set(e NewAddStickerToSet) bool {
    x := d.http_request("addStickerToSet", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSetStickerPositionInSet {
pub:
	sticker string //File identifier of the sticker
	position int //New sticker position in the set, zero-based
}
// set_sticker_position_in_set Use this method to move a sticker in a set created by the bot to a specific position . Returns True on success.
pub fn (d Bot) set_sticker_position_in_set(e NewSetStickerPositionInSet) bool {
    x := d.http_request("setStickerPositionInSet", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewDeleteStickerFromSet {
pub:
	sticker string //File identifier of the sticker
}
// delete_sticker_from_set Use this method to delete a sticker from a set created by the bot. Returns True on success.
pub fn (d Bot) delete_sticker_from_set(e NewDeleteStickerFromSet) bool {
    x := d.http_request("deleteStickerFromSet", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewAnswerInlineQuery {
pub:
	inline_query_id string //Unique identifier for the answered query
	results [] InlineQueryResult //A JSON-serialized array of results for the inline query
	cache_time int //The maximum amount of time in seconds that the result of the inline query may be cached on the server. Defaults to 300.
	is_personal bool //Pass True, if results may be cached on the server side only for the user that sent the query. By default, results may be returned to any user who sends the same query
	next_offset string //Pass the offset that a client should send in the next query with the same text to receive more results. Pass an empty string if there are no more results or if you don‘t support pagination. Offset length can’t exceed 64 bytes.
	switch_pm_text string //If passed, clients will display a button with specified text that switches the user to a private chat with the bot and sends the bot a start message with the parameter switch_pm_parameter
	switch_pm_parameter string //Deep-linking parameter for the /start message sent to the bot when user presses the switch button. 1-64 characters, only A-Z, a-z, 0-9, _ and - are allowed.Example: An inline bot that sends YouTube videos can ask the user to connect the bot to their YouTube account to adapt search results accordingly. To do this, it displays a ‘Connect your YouTube account’ button above the results, or even before showing any. The user presses the button, switches to a private chat with the bot and, in doing so, passes a start parameter that instructs the bot to return an oauth link. Once done, the bot can offer a switch_inline button so that the user can easily return to the chat where they wanted to use the bot's inline capabilities.
}
// answer_inline_query Use this method to send answers to an inline query. On success, True is returned.No more than 50 results per query are allowed.
pub fn (d Bot) answer_inline_query(e NewAnswerInlineQuery) bool {
    x := d.http_request("answerInlineQuery", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSendInvoice {
pub:
	chat_id int //Unique identifier for the target private chat
	title string //Product name, 1-32 characters
	description string //Product description, 1-255 characters
	payload string //Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use for your internal processes.
	provider_token string //Payments provider token, obtained via Botfather
	start_parameter string //Unique deep-linking parameter that can be used to generate this invoice when used as a start parameter
	currency string //Three-letter ISO 4217 currency code, see more on currencies
	prices []LabeledPrice //Price breakdown, a list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.)
	provider_data string //JSON-encoded data about the invoice, which will be shared with the payment provider. A detailed description of required fields should be provided by the payment provider.
	photo_url string //URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service. People like it better when they see what they are paying for.
	photo_size int //Photo size
	photo_width int //Photo width
	photo_height int //Photo height
	need_name bool //Pass True, if you require the user's full name to complete the order
	need_phone_number bool //Pass True, if you require the user's phone number to complete the order
	need_email bool //Pass True, if you require the user's email address to complete the order
	need_shipping_address bool //Pass True, if you require the user's shipping address to complete the order
	send_phone_number_to_provider bool //Pass True, if user's phone number should be sent to provider
	send_email_to_provider bool //Pass True, if user's email address should be sent to provider
	is_flexible bool //Pass True, if the final price depends on the shipping method
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //A JSON-serialized object for an inline keyboard. If empty, one 'Pay total price' button will be shown. If not empty, the first button must be a Pay button.
}
// send_invoice Use this method to send invoices. On success, the sent Message is returned.
pub fn (d Bot) send_invoice(e NewSendInvoice) Message {
    x := d.http_request("sendInvoice", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewAnswerShippingQuery {
pub:
	shipping_query_id string //Unique identifier for the query to be answered
	ok bool //Specify True if delivery to the specified address is possible and False if there are any problems (for example, if delivery to the specified address is not possible)
	shipping_options [] ShippingOption //Required if ok is True. A JSON-serialized array of available shipping options.
	error_message string //Required if ok is False. Error message in human readable form that explains why it is impossible to complete the order (e.g. "Sorry, delivery to your desired address is unavailable'). Telegram will display this message to the user.
}
// answer_shipping_query If you sent an invoice requesting a shipping address and the parameter is_flexible was specified, the Bot API will send an Update with a shipping_query field to the bot. Use this method to reply to shipping queries. On success, True is returned.
pub fn (d Bot) answer_shipping_query(e NewAnswerShippingQuery) bool {
    x := d.http_request("answerShippingQuery", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewAnswerPreCheckoutQuery {
pub:
	pre_checkout_query_id string //Unique identifier for the query to be answered
	ok bool //Specify True if everything is alright (goods are available, etc.) and the bot is ready to proceed with the order. Use False if there are any problems.
	error_message string //Required if ok is False. Error message in human readable form that explains the reason for failure to proceed with the checkout (e.g. "Sorry, somebody just bought the last of our amazing black T-shirts while you were busy filling out your payment details. Please choose a different color or garment!"). Telegram will display this message to the user.
}
// answer_pre_checkout_query Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation in the form of an Update with the field pre_checkout_query. Use this method to respond to such pre-checkout queries. On success, True is returned. Note: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.
pub fn (d Bot) answer_pre_checkout_query(e NewAnswerPreCheckoutQuery) bool {
    x := d.http_request("answerPreCheckoutQuery", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSetPassportDataErrors {
pub:
	user_id int //User identifier
	errors [] PassportElementError //A JSON-serialized array describing the errors
}
// set_passport_data_errors Informs a user that some of the Telegram Passport elements they provided contains errors. The user will not be able to re-submit their Passport to you until the errors are fixed (the contents of the field for which you returned the error must change). Returns True on success.
pub fn (d Bot) set_passport_data_errors(e NewSetPassportDataErrors) bool {
    x := d.http_request("setPassportDataErrors", json.encode(e))
	if x == "" {
		return false
	} else {
		return true
	}
}

pub struct NewSendGame {
pub:
	chat_id int //Unique identifier for the target chat
	game_short_name string //Short name of the game, serves as the unique identifier for the game. Set up your games via Botfather.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //A JSON-serialized object for an inline keyboard. If empty, one ‘Play game_title’ button will be shown. If not empty, the first button must launch the game.
}
// send_game Use this method to send a game. On success, the sent Message is returned.
pub fn (d Bot) send_game(e NewSendGame) Message {
    x := d.http_request("sendGame", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewSetGameScore {
pub:
	user_id int //User identifier
	score int //New score, must be non-negative
	force bool //Pass True, if the high score is allowed to decrease. This can be useful when fixing mistakes or banning cheaters
	disable_edit_message bool //Pass True, if the game message should not be automatically edited to include the current scoreboard
	chat_id int //Required if inline_message_id is not specified. Unique identifier for the target chat
	message_id int //Required if inline_message_id is not specified. Identifier of the sent message
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
}
// set_game_score Use this method to set the score of the specified user in a game. On success, if the message was sent by the bot, returns the edited Message, otherwise returns True. Returns an error, if the new score is not greater than the user&#39;s current score in the chat and force is False.
pub fn (d Bot) set_game_score(e NewSetGameScore) Message {
    x := d.http_request("setGameScore", json.encode(e))
    resp := json.decode(Message, x) or {
        return Message{}
    }
    return resp
}

pub struct NewGetGameHighScores {
pub:
	user_id int //Target user id
	chat_id int //Required if inline_message_id is not specified. Unique identifier for the target chat
	message_id int //Required if inline_message_id is not specified. Identifier of the sent message
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
}
// get_game_high_scores Use this method to get data for high score tables. Will return the score of the specified user and several of his neighbors in a game. On success, returns an Array of GameHighScore objects.
pub fn (d Bot) get_game_high_scores(e NewGetGameHighScores) []GameHighScore {
    x := d.http_request("getGameHighScores", json.encode(e))
    resp := json.decode([]GameHighScore, x) or {
        return [GameHighScore{}]
    }
    return resp
}