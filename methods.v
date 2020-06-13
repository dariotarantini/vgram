module vgram

import json

fn return_bool(data string) bool {
	if data == "true" {
		return true
	} else {
		return false
	}
}
fn return_int(data string) int {
	return data.int()
}
fn return_message(data string) Message {
	resp := json.decode(Message, data) or {
        return Message{}
    }
    return resp
}
fn return_poll(data string) Poll {
	resp := json.decode(Poll, data) or {
        return Poll{}
    }
    return resp
}
fn return_user_profile_photos(data string) UserProfilePhotos {
	resp := json.decode(UserProfilePhotos, data) or {
        return UserProfilePhotos{}
    }
    return resp
}
fn return_file(data string) File {
	resp := json.decode(File, data) or {
        return File{}
    }
    return resp
}
fn return_string(data string) string {
	return data
}
fn return_chat(data string) Chat {
	resp := json.decode(Chat, data) or {
        return Chat{}
    }
    return resp
}
fn return_chat_member(data string) ChatMember {
	resp := json.decode(ChatMember, data) or {
        return ChatMember{}
    }
    return resp
}
fn return_sticker_set(data string) StickerSet {
	resp := json.decode(StickerSet, data) or {
        return StickerSet{}
    }
    return resp
}
fn return_webhook_info(data string) WebhookInfo {
	resp := json.decode(WebhookInfo, data) or {
        return WebhookInfo{}
    }
    return resp
}
fn return_messages(data string) []Message {
	resp := json.decode([]Message, data) or {
        return []Message{}
    }
    return resp
}
fn return_user(data string) User {
	resp := json.decode(User, data) or {
        return User{}
    }
    return resp
}
fn return_gamehighscores(data string) []GameHighScore {
	resp := json.decode([]GameHighScore, data) or {
        return []GameHighScore{}
    }
    return resp
}
fn return_updates(data string) []Update {
	resp := json.decode([]Update, data) or {
        return []Update{}
    }
    return resp
}
fn return_chatmembers(data string) []ChatMember {
	resp := json.decode([]ChatMember, data) or {
        return []ChatMember{}
    }
    return resp
}
fn return_botcommands(data string) []BotCommand{
	resp := json.decode([]BotCommand, data) or {
        return []BotCommand{}
    }
    return resp
}

//GetUpdates Use this method to receive incoming updates using long polling (wiki). An Array of Update objects is returned.
pub struct ConfigGetUpdates {
pub:
	offset int //Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers of previously received updates. By default, updates starting with the earliest unconfirmed update are returned. An update is considered confirmed as soon as getUpdates is called with an offset higher than its update_id. The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue. All previous updates will forgotten.
	limit int //Limits the number of updates to be retrieved. Values between 1-100 are accepted. Defaults to 100.
	timeout int //Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.
	allowed_updates string //json.encode(string[]) A JSON-serialized list of the update types you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all updates regardless of type (default). If not specified, the previous setting will be used.Please note that this parameter doesn't affect updates created before the call to the getUpdates, so unwanted updates may be received for a short period of time.
}
pub fn (d Bot) get_updates(conf ConfigGetUpdates) []Update {
	resp := d.http_request("getUpdates", json.encode(conf)) 
	return return_updates(resp)
}

//SetWebhook Use this method to specify a url and receive incoming updates via an outgoing webhook. Whenever there is an update for the bot, we will send an HTTPS POST request to the specified url, containing a JSON-serialized Update. In case of an unsuccessful request, we will give up after a reasonable amount of attempts. Returns True on success. If you'd like to make sure that the Webhook request comes from Telegram, we recommend using a secret path in the URL, e.g. https://www.example.com/<token>. Since nobody else knows your bot‘s token, you can be pretty sure it’s us.
pub struct ConfigSetWebhook {
pub:
	url string //HTTPS url to send updates to. Use an empty string to remove webhook integration
	certificate string //Upload your public key certificate so that the root certificate in use can be checked. See our self-signed guide for details.
	max_connections int //Maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit the load on your bot‘s server, and higher values to increase your bot’s throughput.
	allowed_updates string //json.encode(string[]) A JSON-serialized list of the update types you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all updates regardless of type (default). If not specified, the previous setting will be used.Please note that this parameter doesn't affect updates created before the call to the setWebhook, so unwanted updates may be received for a short period of time.
}
pub fn (d Bot) set_webhook(conf ConfigSetWebhook) bool {
	resp := d.http_request("setWebhook", json.encode(conf))
	return return_bool(resp)
}

//DeleteWebhook Use this method to remove webhook integration if you decide to switch back to getUpdates. Returns True on success. Requires no parameters.
pub fn (d Bot) delete_webhook() bool {
	resp := d.http_request("deleteWebhook", json.encode(false))
	return return_bool(resp)
}

//GetWebhookInfo Use this method to get current webhook status. Requires no parameters. On success, returns a WebhookInfo object. If the bot is using getUpdates, will return an object with the url field empty.
pub fn (d Bot) get_webhook_info() WebhookInfo {
	resp := d.http_request("getWebhookInfo", json.encode(false))
	return return_webhook_info(resp)
}

//GetMe A simple method for testing your bot's auth token. Requires no parameters. Returns basic information about the bot in form of a User object.
pub fn (d Bot) get_me() User {
	resp := d.http_request("getMe", json.encode(false))
	return return_user(resp)
}

//SendMessage Use this method to send text messages. On success, the sent Message is returned.
pub struct ConfigSendMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	text string //Text of the message to be sent, 1-4096 characters after entities parsing
	parse_mode string //Mode for parsing entities in the message text. See formatting options for more details.
	disable_web_page_preview bool //Disables link previews for links in this message
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_message(conf ConfigSendMessage) Message {
	resp := d.http_request("sendMessage", json.encode(conf))
	return return_message(resp)
}

//ForwardMessage Use this method to forward messages of any kind. On success, the sent Message is returned.
pub struct ConfigForwardMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	from_chat_id int //Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	message_id int //Message identifier in the chat specified in from_chat_id
}
pub fn (d Bot) forward_message(conf ConfigForwardMessage) Message {
	resp := d.http_request("forwardMessage", json.encode(conf))
	return return_message(resp)
}

//SendPhoto Use this method to send photos. On success, the sent Message is returned.
pub struct ConfigSendPhoto {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	photo string //Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. More info on Sending Files »
	caption string //Photo caption (may also be used when resending photos by file_id), 0-1024 characters after entities parsing
	parse_mode string //Mode for parsing entities in the photo caption. See formatting options for more details.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_photo(conf ConfigSendPhoto) Message {
	resp := d.http_request("sendPhoto", json.encode(conf))
	return return_message(resp)
}

//SendAudio Use this method to send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .MP3 or .M4A format. On success, the sent Message is returned. Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future. For sending voice messages, use the sendVoice method instead.
pub struct ConfigSendAudio {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	audio string //Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	caption string //Audio caption, 0-1024 characters after entities parsing
	parse_mode string //Mode for parsing entities in the audio caption. See formatting options for more details.
	duration int //Duration of the audio in seconds
	performer string //Performer
	title string //Track name
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_audio(conf ConfigSendAudio) Message {
	resp := d.http_request("sendAudio", json.encode(conf))
	return return_message(resp)
}

//SendDocument Use this method to send general files. On success, the sent Message is returned. Bots can currently send files of any type of up to 50 MB in size, this limit may be changed in the future.
pub struct ConfigSendDocument {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	document string //File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string //Document caption (may also be used when resending documents by file_id), 0-1024 characters after entities parsing
	parse_mode string //Mode for parsing entities in the document caption. See formatting options for more details.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_document(conf ConfigSendDocument) Message {
	resp := d.http_request("sendDocument", json.encode(conf))
	return return_message(resp)
}

//SendVideo Use this method to send video files, Telegram clients support mp4 videos (other formats may be sent as Document). On success, the sent Message is returned. Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.
pub struct ConfigSendVideo {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	video string //Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data. More info on Sending Files »
	duration int //Duration of sent video in seconds
	width int //Video width
	height int //Video height
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string //Video caption (may also be used when resending videos by file_id), 0-1024 characters after entities parsing
	parse_mode string //Mode for parsing entities in the video caption. See formatting options for more details.
	supports_streaming bool //Pass True, if the uploaded video is suitable for streaming
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_video(conf ConfigSendVideo) Message {
	resp := d.http_request("sendVideo", json.encode(conf))
	return return_message(resp)
}

//SendAnimation Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound). On success, the sent Message is returned. Bots can currently send animation files of up to 50 MB in size, this limit may be changed in the future.
pub struct ConfigSendAnimation {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	animation string //Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More info on Sending Files »
	duration int //Duration of sent animation in seconds
	width int //Animation width
	height int //Animation height
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string //Animation caption (may also be used when resending animation by file_id), 0-1024 characters after entities parsing
	parse_mode string //Mode for parsing entities in the animation caption. See formatting options for more details.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_animation(conf ConfigSendAnimation) Message {
	resp := d.http_request("sendAnimation", json.encode(conf))
	return return_message(resp)
}

//SendVoice Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .OGG file encoded with OPUS (other formats may be sent as Audio or Document). On success, the sent Message is returned. Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.
pub struct ConfigSendVoice {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	voice string //Audio file to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	caption string //Voice message caption, 0-1024 characters after entities parsing
	parse_mode string //Mode for parsing entities in the voice message caption. See formatting options for more details.
	duration int //Duration of the voice message in seconds
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_voice(conf ConfigSendVoice) Message {
	resp := d.http_request("sendVoice", json.encode(conf))
	return return_message(resp)
}

//SendVideoNote As of v.4.0, Telegram clients support rounded square mp4 videos of up to 1 minute long. Use this method to send video messages. On success, the sent Message is returned.
pub struct ConfigSendVideoNote {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	video_note string //Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers (recommended) or upload a new video using multipart/form-data. More info on Sending Files ». Sending video notes by a URL is currently unsupported
	duration int //Duration of sent video in seconds
	length int //Video width and height, i.e. diameter of the video message
	thumb string //Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_video_note(conf ConfigSendVideoNote) Message {
	resp := d.http_request("sendVideoNote", json.encode(conf))
	return return_message(resp)
}

//SendMediaGroup Use this method to send a group of photos or videos as an album. On success, an array of the sent Messages is returned.
pub struct ConfigSendMediaGroup {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	media string //json.encode(InputMediaPhoto and InputMediaVideo[]) A JSON-serialized array describing photos and videos to be sent, must include 2-10 items
	disable_notification bool //Sends the messages silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the messages are a reply, ID of the original message
}
pub fn (d Bot) send_media_group(conf ConfigSendMediaGroup) []Message {
	resp := d.http_request("sendMediaGroup", json.encode(conf)) 
	return return_messages(resp)
}

//SendLocation Use this method to send point on the map. On success, the sent Message is returned.
pub struct ConfigSendLocation {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	latitude f32 //Latitude of the location
	longitude f32 //Longitude of the location
	live_period int //Period in seconds for which the location will be updated (see Live Locations, should be between 60 and 86400.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_location(conf ConfigSendLocation) Message {
	resp := d.http_request("sendLocation", json.encode(conf))
	return return_message(resp)
}

//EditMessageLiveLocation Use this method to edit live location messages. A location can be edited until its live_period expires or editing is explicitly disabled by a call to stopMessageLiveLocation. On success, if the edited message was sent by the bot, the edited Message is returned, otherwise True is returned.
pub struct ConfigEditMessageLiveLocation {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	latitude f32 //Latitude of new location
	longitude f32 //Longitude of new location
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for a new inline keyboard.
}
pub fn (d Bot) edit_message_live_location(conf ConfigEditMessageLiveLocation) Message {
	resp := d.http_request("editMessageLiveLocation", json.encode(conf))
	return return_message(resp)
}

//StopMessageLiveLocation Use this method to stop updating a live location message before live_period expires. On success, if the message was sent by the bot, the sent Message is returned, otherwise True is returned.
pub struct ConfigStopMessageLiveLocation {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message with live location to stop
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for a new inline keyboard.
}
pub fn (d Bot) stop_message_live_location(conf ConfigStopMessageLiveLocation) Message {
	resp := d.http_request("stopMessageLiveLocation", json.encode(conf))
	return return_message(resp)
}

//SendVenue Use this method to send information about a venue. On success, the sent Message is returned.
pub struct ConfigSendVenue {
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
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_venue(conf ConfigSendVenue) Message {
	resp := d.http_request("sendVenue", json.encode(conf))
	return return_message(resp)
}

//SendContact Use this method to send phone contacts. On success, the sent Message is returned.
pub struct ConfigSendContact {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	phone_number string //Contact's phone number
	first_name string //Contact's first name
	last_name string //Contact's last name
	vcard string //Additional data about the contact in the form of a vCard, 0-2048 bytes
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove keyboard or to force a reply from the user.
}
pub fn (d Bot) send_contact(conf ConfigSendContact) Message {
	resp := d.http_request("sendContact", json.encode(conf))
	return return_message(resp)
}

//SendPoll Use this method to send a native poll. On success, the sent Message is returned.
pub struct ConfigSendPoll {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	question string //Poll question, 1-255 characters
	options string //json.encode(string[]) A JSON-serialized list of answer options, 2-10 strings 1-100 characters each
	is_anonymous bool //True, if the poll needs to be anonymous, defaults to True
	@type string //Poll type, “quiz” or “regular”, defaults to “regular”
	allows_multiple_answers bool //True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False
	correct_option_id int //0-based identifier of the correct answer option, required for polls in quiz mode
	explanation string //Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing
	explanation_parse_mode string //Mode for parsing entities in the explanation. See formatting options for more details.
	open_period int //Amount of time in seconds the poll will be active after creation, 5-600. Can't be used together with close_date.
	close_date int //Point in time (Unix timestamp) when the poll will be automatically closed. Must be at least 5 and no more than 600 seconds in the future. Can't be used together with open_period.
	is_closed bool //Pass True, if the poll needs to be immediately closed. This can be useful for poll preview.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_poll(conf ConfigSendPoll) Message {
	resp := d.http_request("sendPoll", json.encode(conf))
	return return_message(resp)
}

//SendDice Use this method to send a dice, which will have a random value from 1 to 6. On success, the sent Message is returned. (Yes, we're aware of the “proper” singular of die. But it's awkward, and we decided to help it change. One dice at a time!)
pub struct ConfigSendDice {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	emoji string //Emoji on which the dice throw animation is based. Currently, must be one of “” or “”. Defauts to “”
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_dice(conf ConfigSendDice) Message {
	resp := d.http_request("sendDice", json.encode(conf))
	return return_message(resp)
}

//SendChatAction Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success. We only recommend using this method when a response from the bot will take a noticeable amount of time to arrive.
pub struct ConfigSendChatAction {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	action string //Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location data, record_video_note or upload_video_note for video notes.
}
pub fn (d Bot) send_chat_action(conf ConfigSendChatAction) bool {
	resp := d.http_request("sendChatAction", json.encode(conf))
	return return_bool(resp)
}

//GetUserProfilePhotos Use this method to get a list of profile pictures for a user. Returns a UserProfilePhotos object.
pub struct ConfigGetUserProfilePhotos {
pub:
	user_id int //Unique identifier of the target user
	offset int //Sequential number of the first photo to be returned. By default, all photos are returned.
	limit int //Limits the number of photos to be retrieved. Values between 1-100 are accepted. Defaults to 100.
}
pub fn (d Bot) get_user_profile_photos(conf ConfigGetUserProfilePhotos) UserProfilePhotos {
	resp := d.http_request("getUserProfilePhotos", json.encode(conf))
	return return_user_profile_photos(resp)
}

//GetFile Use this method to get basic info about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a File object is returned. The file can then be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile again.
pub struct ConfigGetFile {
pub:
	file_id string //File identifier to get info about
}
pub fn (d Bot) get_file(conf ConfigGetFile) File {
	resp := d.http_request("getFile", json.encode(conf))
	return return_file(resp)
}

//KickChatMember Use this method to kick a user from a group, a supergroup or a channel. In the case of supergroups and channels, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub struct ConfigKickChatMember {
pub:
	chat_id string //Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)
	user_id int //Unique identifier of the target user
	until_date int //Date when the user will be unbanned, unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever
}
pub fn (d Bot) kick_chat_member(conf ConfigKickChatMember) bool {
	resp := d.http_request("kickChatMember", json.encode(conf))
	return return_bool(resp)
}

//UnbanChatMember Use this method to unban a previously kicked user in a supergroup or channel. The user will not return to the group or channel automatically, but will be able to join via link, etc. The bot must be an administrator for this to work. Returns True on success.
pub struct ConfigUnbanChatMember {
pub:
	chat_id string //Unique identifier for the target group or username of the target supergroup or channel (in the format @username)
	user_id int //Unique identifier of the target user
}
pub fn (d Bot) unban_chat_member(conf ConfigUnbanChatMember) bool {
	resp := d.http_request("unbanChatMember", json.encode(conf))
	return return_bool(resp)
}

//RestrictChatMember Use this method to restrict a user in a supergroup. The bot must be an administrator in the supergroup for this to work and must have the appropriate admin rights. Pass True for all permissions to lift restrictions from a user. Returns True on success.
pub struct ConfigRestrictChatMember {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	user_id int //Unique identifier of the target user
	permissions ChatPermissions //New user permissions
	until_date int //Date when restrictions will be lifted for the user, unix time. If user is restricted for more than 366 days or less than 30 seconds from the current time, they are considered to be restricted forever
}
pub fn (d Bot) restrict_chat_member(conf ConfigRestrictChatMember) bool {
	resp := d.http_request("restrictChatMember", json.encode(conf))
	return return_bool(resp)
}

//PromoteChatMember Use this method to promote or demote a user in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Pass False for all boolean parameters to demote a user. Returns True on success.
pub struct ConfigPromoteChatMember {
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
	can_promote_members bool //Pass True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that he has promoted, directly or indirectly (promoted by administrators that were appointed by him)
}
pub fn (d Bot) promote_chat_member(conf ConfigPromoteChatMember) bool {
	resp := d.http_request("promoteChatMember", json.encode(conf))
	return return_bool(resp)
}

//SetChatAdministratorCustomTitle Use this method to set a custom title for an administrator in a supergroup promoted by the bot. Returns True on success.
pub struct ConfigSetChatAdministratorCustomTitle {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	user_id int //Unique identifier of the target user
	custom_title string //New custom title for the administrator; 0-16 characters, emoji are not allowed
}
pub fn (d Bot) set_chat_administrator_custom_title(conf ConfigSetChatAdministratorCustomTitle) bool {
	resp := d.http_request("setChatAdministratorCustomTitle", json.encode(conf))
	return return_bool(resp)
}

//SetChatPermissions Use this method to set default chat permissions for all members. The bot must be an administrator in the group or a supergroup for this to work and must have the can_restrict_members admin rights. Returns True on success.
pub struct ConfigSetChatPermissions {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	permissions ChatPermissions //New default chat permissions
}
pub fn (d Bot) set_chat_permissions(conf ConfigSetChatPermissions) bool {
	resp := d.http_request("setChatPermissions", json.encode(conf))
	return return_bool(resp)
}

//ExportChatInviteLink Use this method to generate a new invite link for a chat; any previously generated link is revoked. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns the new invite link as String on success.
pub struct ConfigExportChatInviteLink {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
}
pub fn (d Bot) export_chat_invite_link(conf ConfigExportChatInviteLink) string {
	resp := d.http_request("exportChatInviteLink", json.encode(conf))
	return return_string(resp)
}

//SetChatPhoto Use this method to set a new profile photo for the chat. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub struct ConfigSetChatPhoto {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	photo string //New chat photo, uploaded using multipart/form-data
}
pub fn (d Bot) set_chat_photo(conf ConfigSetChatPhoto) bool {
	resp := d.http_request("setChatPhoto", json.encode(conf))
	return return_bool(resp)
}

//DeleteChatPhoto Use this method to delete a chat photo. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub struct ConfigDeleteChatPhoto {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
}
pub fn (d Bot) delete_chat_photo(conf ConfigDeleteChatPhoto) bool {
	resp := d.http_request("deleteChatPhoto", json.encode(conf))
	return return_bool(resp)
}

//SetChatTitle Use this method to change the title of a chat. Titles can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub struct ConfigSetChatTitle {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	title string //New chat title, 1-255 characters
}
pub fn (d Bot) set_chat_title(conf ConfigSetChatTitle) bool {
	resp := d.http_request("setChatTitle", json.encode(conf))
	return return_bool(resp)
}

//SetChatDescription Use this method to change the description of a group, a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
pub struct ConfigSetChatDescription {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	description string //New chat description, 0-255 characters
}
pub fn (d Bot) set_chat_description(conf ConfigSetChatDescription) bool {
	resp := d.http_request("setChatDescription", json.encode(conf))
	return return_bool(resp)
}

//PinChatMessage Use this method to pin a message in a group, a supergroup, or a channel. The bot must be an administrator in the chat for this to work and must have the ‘can_pin_messages’ admin right in the supergroup or ‘can_edit_messages’ admin right in the channel. Returns True on success.
pub struct ConfigPinChatMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Identifier of a message to pin
	disable_notification bool //Pass True, if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels.
}
pub fn (d Bot) pin_chat_message(conf ConfigPinChatMessage) bool {
	resp := d.http_request("pinChatMessage", json.encode(conf))
	return return_bool(resp)
}

//UnpinChatMessage Use this method to unpin a message in a group, a supergroup, or a channel. The bot must be an administrator in the chat for this to work and must have the ‘can_pin_messages’ admin right in the supergroup or ‘can_edit_messages’ admin right in the channel. Returns True on success.
pub struct ConfigUnpinChatMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
}
pub fn (d Bot) unpin_chat_message(conf ConfigUnpinChatMessage) bool {
	resp := d.http_request("unpinChatMessage", json.encode(conf))
	return return_bool(resp)
}

//LeaveChat Use this method for your bot to leave a group, supergroup or channel. Returns True on success.
pub struct ConfigLeaveChat {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
pub fn (d Bot) leave_chat(conf ConfigLeaveChat) bool {
	resp := d.http_request("leaveChat", json.encode(conf))
	return return_bool(resp)
}

//GetChat Use this method to get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Returns a Chat object on success.
pub struct ConfigGetChat {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
pub fn (d Bot) get_chat(conf ConfigGetChat) Chat {
	resp := d.http_request("getChat", json.encode(conf))
	return return_chat(resp)
}

//GetChatAdministrators Use this method to get a list of administrators in a chat. On success, returns an Array of ChatMember objects that contains information about all chat administrators except other bots. If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned.
pub struct ConfigGetChatAdministrators {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
pub fn (d Bot) get_chat_administrators(conf ConfigGetChatAdministrators) []ChatMember {
	resp := d.http_request("getChatAdministrators", json.encode(conf)) 
	return return_chatmembers(resp)
}

//GetChatMembersCount Use this method to get the number of members in a chat. Returns Int on success.
pub struct ConfigGetChatMembersCount {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
}
pub fn (d Bot) get_chat_members_count(conf ConfigGetChatMembersCount) int {
	resp := d.http_request("getChatMembersCount", json.encode(conf))
	return return_int(resp)
}

//GetChatMember Use this method to get information about a member of a chat. Returns a ChatMember object on success.
pub struct ConfigGetChatMember {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
	user_id int //Unique identifier of the target user
}
pub fn (d Bot) get_chat_member(conf ConfigGetChatMember) ChatMember {
	resp := d.http_request("getChatMember", json.encode(conf))
	return return_chat_member(resp)
}

//SetChatStickerSet Use this method to set a new group sticker set for a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.
pub struct ConfigSetChatStickerSet {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	sticker_set_name string //Name of the sticker set to be set as the group sticker set
}
pub fn (d Bot) set_chat_sticker_set(conf ConfigSetChatStickerSet) bool {
	resp := d.http_request("setChatStickerSet", json.encode(conf))
	return return_bool(resp)
}

//DeleteChatStickerSet Use this method to delete a group sticker set from a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.
pub struct ConfigDeleteChatStickerSet {
pub:
	chat_id string //Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
}
pub fn (d Bot) delete_chat_sticker_set(conf ConfigDeleteChatStickerSet) bool {
	resp := d.http_request("deleteChatStickerSet", json.encode(conf))
	return return_bool(resp)
}

//AnswerCallbackQuery Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.
pub struct ConfigAnswerCallbackQuery {
pub:
	callback_query_id string //Unique identifier for the query to be answered
	text string //Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters
	show_alert bool //If true, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.
	url string //URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @Botfather, specify the URL that opens your game — note that this will only work if the query comes from a callback_game button.Otherwise, you may use links like t.me/your_bot?start=XXXX that open your bot with a parameter.
	cache_time int //The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.
}
pub fn (d Bot) answer_callback_query(conf ConfigAnswerCallbackQuery) bool {
	resp := d.http_request("answerCallbackQuery", json.encode(conf))
	return return_bool(resp)
}

//SetMyCommands Use this method to change the list of the bot's commands. Returns True on success.
pub struct ConfigSetMyCommands {
pub:
	commands string //json.encode(BotCommand[]) A JSON-serialized list of bot commands to be set as the list of the bot's commands. At most 100 commands can be specified.
}
pub fn (d Bot) set_my_commands(conf ConfigSetMyCommands) bool {
	resp := d.http_request("setMyCommands", json.encode(conf))
	return return_bool(resp)
}

//GetMyCommands Use this method to get the current list of the bot's commands. Requires no parameters. Returns Array of BotCommand on success.
pub fn (d Bot) get_my_commands() []BotCommand {
	resp := d.http_request("getMyCommands", json.encode(false)) 
	return return_botcommands(resp)
}

//EditMessageText Use this method to edit text and game messages. On success, if edited message is sent by the bot, the edited Message is returned, otherwise True is returned.
pub struct ConfigEditMessageText {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	text string //New text of the message, 1-4096 characters after entities parsing
	parse_mode string //Mode for parsing entities in the message text. See formatting options for more details.
	disable_web_page_preview bool //Disables link previews for links in this message
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard.
}
pub fn (d Bot) edit_message_text(conf ConfigEditMessageText) Message {
	resp := d.http_request("editMessageText", json.encode(conf))
	return return_message(resp)
}

//EditMessageCaption Use this method to edit captions of messages. On success, if edited message is sent by the bot, the edited Message is returned, otherwise True is returned.
pub struct ConfigEditMessageCaption {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	caption string //New caption of the message, 0-1024 characters after entities parsing
	parse_mode string //Mode for parsing entities in the message caption. See formatting options for more details.
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard.
}
pub fn (d Bot) edit_message_caption(conf ConfigEditMessageCaption) Message {
	resp := d.http_request("editMessageCaption", json.encode(conf))
	return return_message(resp)
}

//EditMessageMedia Use this method to edit animation, audio, document, photo, or video messages. If a message is a part of a message album, then it can be edited only to a photo or a video. Otherwise, message type can be changed arbitrarily. When inline message is edited, new file can't be uploaded. Use previously uploaded file via its file_id or specify a URL. On success, if the edited message was sent by the bot, the edited Message is returned, otherwise True is returned.
pub struct ConfigEditMessageMedia {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	media string //json.encode(InputMedia) A JSON-serialized object for a new media content of the message
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for a new inline keyboard.
}
pub fn (d Bot) edit_message_media(conf ConfigEditMessageMedia) Message {
	resp := d.http_request("editMessageMedia", json.encode(conf))
	return return_message(resp)
}

//EditMessageReplyMarkup Use this method to edit only the reply markup of messages. On success, if edited message is sent by the bot, the edited Message is returned, otherwise True is returned.
pub struct ConfigEditMessageReplyMarkup {
pub:
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Required if inline_message_id is not specified. Identifier of the message to edit
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard.
}
pub fn (d Bot) edit_message_reply_markup(conf ConfigEditMessageReplyMarkup) Message {
	resp := d.http_request("editMessageReplyMarkup", json.encode(conf))
	return return_message(resp)
}

//StopPoll Use this method to stop a poll which was sent by the bot. On success, the stopped Poll with the final results is returned.
pub struct ConfigStopPoll {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Identifier of the original message with the poll
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for a new message inline keyboard.
}
pub fn (d Bot) stop_poll(conf ConfigStopPoll) Poll {
	resp := d.http_request("stopPoll", json.encode(conf))
	return return_poll(resp)
}

//DeleteMessage Use this method to delete a message, including service messages, with the following limitations:- A message can only be deleted if it was sent less than 48 hours ago.- A dice message in a private chat can only be deleted if it was sent more than 24 hours ago.- Bots can delete outgoing messages in private chats, groups, and supergroups.- Bots can delete incoming messages in private chats.- Bots granted can_post_messages permissions can delete outgoing messages in channels.- If the bot is an administrator of a group, it can delete any message there.- If the bot has can_delete_messages permission in a supergroup or a channel, it can delete any message there.Returns True on success.
pub struct ConfigDeleteMessage {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	message_id int //Identifier of the message to delete
}
pub fn (d Bot) delete_message(conf ConfigDeleteMessage) bool {
	resp := d.http_request("deleteMessage", json.encode(conf))
	return return_bool(resp)
}

//SendSticker Use this method to send static .WEBP or animated .TGS stickers. On success, the sent Message is returned.
pub struct ConfigSendSticker {
pub:
	chat_id string //Unique identifier for the target chat or username of the target channel (in the format @channelusername)
	sticker string //Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .WEBP file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.
}
pub fn (d Bot) send_sticker(conf ConfigSendSticker) Message {
	resp := d.http_request("sendSticker", json.encode(conf))
	return return_message(resp)
}

//GetStickerSet Use this method to get a sticker set. On success, a StickerSet object is returned.
pub struct ConfigGetStickerSet {
pub:
	name string //Name of the sticker set
}
pub fn (d Bot) get_sticker_set(conf ConfigGetStickerSet) StickerSet {
	resp := d.http_request("getStickerSet", json.encode(conf))
	return return_sticker_set(resp)
}

//UploadStickerFile Use this method to upload a .PNG file with a sticker for later use in createNewStickerSet and addStickerToSet methods (can be used multiple times). Returns the uploaded File on success.
pub struct ConfigUploadStickerFile {
pub:
	user_id int //User identifier of sticker file owner
	png_sticker string //PNG image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. More info on Sending Files »
}
pub fn (d Bot) upload_sticker_file(conf ConfigUploadStickerFile) File {
	resp := d.http_request("uploadStickerFile", json.encode(conf))
	return return_file(resp)
}

//CreateNewStickerSet Use this method to create a new sticker set owned by a user. The bot will be able to edit the sticker set thus created. You must use exactly one of the fields png_sticker or tgs_sticker. Returns True on success.
pub struct ConfigCreateNewStickerSet {
pub:
	user_id int //User identifier of created sticker set owner
	name string //Short name of sticker set, to be used in t.me/addstickers/ URLs (e.g., animals). Can contain only english letters, digits and underscores. Must begin with a letter, can't contain consecutive underscores and must end in “_by_<bot username>”. <bot_username> is case insensitive. 1-64 characters.
	title string //Sticker set title, 1-64 characters
	png_sticker string //PNG image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	tgs_sticker string //TGS animation with the sticker, uploaded using multipart/form-data. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
	emojis string //One or more emoji corresponding to the sticker
	contains_masks bool //Pass True, if a set of mask stickers should be created
	mask_position string //json.encode(MaskPosition) A JSON-serialized object for position where the mask should be placed on faces
}
pub fn (d Bot) create_new_sticker_set(conf ConfigCreateNewStickerSet) bool {
	resp := d.http_request("createNewStickerSet", json.encode(conf))
	return return_bool(resp)
}

//AddStickerToSet Use this method to add a new sticker to a set created by the bot. You must use exactly one of the fields png_sticker or tgs_sticker. Animated stickers can be added to animated sticker sets and only to them. Animated sticker sets can have up to 50 stickers. Static sticker sets can have up to 120 stickers. Returns True on success.
pub struct ConfigAddStickerToSet {
pub:
	user_id int //User identifier of sticker set owner
	name string //Sticker set name
	png_sticker string //PNG image with the sticker, must be up to 512 kilobytes in size, dimensions must not exceed 512px, and either width or height must be exactly 512px. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files »
	tgs_sticker string //TGS animation with the sticker, uploaded using multipart/form-data. See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
	emojis string //One or more emoji corresponding to the sticker
	mask_position string //json.encode(MaskPosition) A JSON-serialized object for position where the mask should be placed on faces
}
pub fn (d Bot) add_sticker_to_set(conf ConfigAddStickerToSet) bool {
	resp := d.http_request("addStickerToSet", json.encode(conf))
	return return_bool(resp)
}

//SetStickerPositionInSet Use this method to move a sticker in a set created by the bot to a specific position. Returns True on success.
pub struct ConfigSetStickerPositionInSet {
pub:
	sticker string //File identifier of the sticker
	position int //New sticker position in the set, zero-based
}
pub fn (d Bot) set_sticker_position_in_set(conf ConfigSetStickerPositionInSet) bool {
	resp := d.http_request("setStickerPositionInSet", json.encode(conf))
	return return_bool(resp)
}

//DeleteStickerFromSet Use this method to delete a sticker from a set created by the bot. Returns True on success.
pub struct ConfigDeleteStickerFromSet {
pub:
	sticker string //File identifier of the sticker
}
pub fn (d Bot) delete_sticker_from_set(conf ConfigDeleteStickerFromSet) bool {
	resp := d.http_request("deleteStickerFromSet", json.encode(conf))
	return return_bool(resp)
}

//SetStickerSetThumb Use this method to set the thumbnail of a sticker set. Animated thumbnails can be set for animated sticker sets only. Returns True on success.
pub struct ConfigSetStickerSetThumb {
pub:
	name string //Sticker set name
	user_id int //User identifier of the sticker set owner
	thumb string //A PNG image with the thumbnail, must be up to 128 kilobytes in size and have width and height exactly 100px, or a TGS animation with the thumbnail up to 32 kilobytes in size; see https://core.telegram.org/animated_stickers#technical-requirements for animated sticker technical requirements. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More info on Sending Files ». Animated sticker set thumbnail can't be uploaded via HTTP URL.
}
pub fn (d Bot) set_sticker_set_thumb(conf ConfigSetStickerSetThumb) bool {
	resp := d.http_request("setStickerSetThumb", json.encode(conf))
	return return_bool(resp)
}

//AnswerInlineQuery Use this method to send answers to an inline query. On success, True is returned.No more than 50 results per query are allowed.
pub struct ConfigAnswerInlineQuery {
pub:
	inline_query_id string //Unique identifier for the answered query
	results string //json.encode(InlineQueryResult[]) A JSON-serialized array of results for the inline query
	cache_time int //The maximum amount of time in seconds that the result of the inline query may be cached on the server. Defaults to 300.
	is_personal bool //Pass True, if results may be cached on the server side only for the user that sent the query. By default, results may be returned to any user who sends the same query
	next_offset string //Pass the offset that a client should send in the next query with the same text to receive more results. Pass an empty string if there are no more results or if you don‘t support pagination. Offset length can’t exceed 64 bytes.
	switch_pm_text string //If passed, clients will display a button with specified text that switches the user to a private chat with the bot and sends the bot a start message with the parameter switch_pm_parameter
	switch_pm_parameter string //Deep-linking parameter for the /start message sent to the bot when user presses the switch button. 1-64 characters, only A-Z, a-z, 0-9, _ and - are allowed.Example: An inline bot that sends YouTube videos can ask the user to connect the bot to their YouTube account to adapt search results accordingly. To do this, it displays a ‘Connect your YouTube account’ button above the results, or even before showing any. The user presses the button, switches to a private chat with the bot and, in doing so, passes a start parameter that instructs the bot to return an oauth link. Once done, the bot can offer a switch_inline button so that the user can easily return to the chat where they wanted to use the bot's inline capabilities.
}
pub fn (d Bot) answer_inline_query(conf ConfigAnswerInlineQuery) bool {
	resp := d.http_request("answerInlineQuery", json.encode(conf))
	return return_bool(resp)
}

//SendInvoice Use this method to send invoices. On success, the sent Message is returned.
pub struct ConfigSendInvoice {
pub:
	chat_id string //Unique identifier for the target private chat
	title string //Product name, 1-32 characters
	description string //Product description, 1-255 characters
	payload string //Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use for your internal processes.
	provider_token string //Payments provider token, obtained via Botfather
	start_parameter string //Unique deep-linking parameter that can be used to generate this invoice when used as a start parameter
	currency string //Three-letter ISO 4217 currency code, see more on currencies
	prices string //json.encode(LabeledPrice[]) Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.)
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
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard. If empty, one 'Pay total price' button will be shown. If not empty, the first button must be a Pay button.
}
pub fn (d Bot) send_invoice(conf ConfigSendInvoice) Message {
	resp := d.http_request("sendInvoice", json.encode(conf))
	return return_message(resp)
}

//AnswerShippingQuery If you sent an invoice requesting a shipping address and the parameter is_flexible was specified, the Bot API will send an Update with a shipping_query field to the bot. Use this method to reply to shipping queries. On success, True is returned.
pub struct ConfigAnswerShippingQuery {
pub:
	shipping_query_id string //Unique identifier for the query to be answered
	ok bool //Specify True if delivery to the specified address is possible and False if there are any problems (for example, if delivery to the specified address is not possible)
	shipping_options string //json.encode(ShippingOption[]) Required if ok is True. A JSON-serialized array of available shipping options.
	error_message string //Required if ok is False. Error message in human readable form that explains why it is impossible to complete the order (e.g. "Sorry, delivery to your desired address is unavailable'). Telegram will display this message to the user.
}
pub fn (d Bot) answer_shipping_query(conf ConfigAnswerShippingQuery) bool {
	resp := d.http_request("answerShippingQuery", json.encode(conf))
	return return_bool(resp)
}

//AnswerPreCheckoutQuery Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation in the form of an Update with the field pre_checkout_query. Use this method to respond to such pre-checkout queries. On success, True is returned. Note: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.
pub struct ConfigAnswerPreCheckoutQuery {
pub:
	pre_checkout_query_id string //Unique identifier for the query to be answered
	ok bool //Specify True if everything is alright (goods are available, etc.) and the bot is ready to proceed with the order. Use False if there are any problems.
	error_message string //Required if ok is False. Error message in human readable form that explains the reason for failure to proceed with the checkout (e.g. "Sorry, somebody just bought the last of our amazing black T-shirts while you were busy filling out your payment details. Please choose a different color or garment!"). Telegram will display this message to the user.
}
pub fn (d Bot) answer_pre_checkout_query(conf ConfigAnswerPreCheckoutQuery) bool {
	resp := d.http_request("answerPreCheckoutQuery", json.encode(conf))
	return return_bool(resp)
}

//SetPassportDataErrors Informs a user that some of the Telegram Passport elements they provided contains errors. The user will not be able to re-submit their Passport to you until the errors are fixed (the contents of the field for which you returned the error must change). Returns True on success. Use this if the data submitted by the user doesn't satisfy the standards your service requires for any reason. For example, if a birthday date seems invalid, a submitted document is blurry, a scan shows evidence of tampering, etc. Supply some details in the error message to make sure the user knows how to correct the issues.
pub struct ConfigSetPassportDataErrors {
pub:
	user_id int //User identifier
	errors string //json.encode(PassportElementError[]) A JSON-serialized array describing the errors
}
pub fn (d Bot) set_passport_data_errors(conf ConfigSetPassportDataErrors) bool {
	resp := d.http_request("setPassportDataErrors", json.encode(conf))
	return return_bool(resp)
}

//SendGame Use this method to send a game. On success, the sent Message is returned.
pub struct ConfigSendGame {
pub:
	chat_id string //Unique identifier for the target chat
	game_short_name string //Short name of the game, serves as the unique identifier for the game. Set up your games via Botfather.
	disable_notification bool //Sends the message silently. Users will receive a notification with no sound.
	reply_to_message_id int //If the message is a reply, ID of the original message
	reply_markup string //json.encode(InlineKeyboardMarkup) A JSON-serialized object for an inline keyboard. If empty, one ‘Play game_title’ button will be shown. If not empty, the first button must launch the game.
}
pub fn (d Bot) send_game(conf ConfigSendGame) Message {
	resp := d.http_request("sendGame", json.encode(conf))
	return return_message(resp)
}

//SetGameScore Use this method to set the score of the specified user in a game. On success, if the message was sent by the bot, returns the edited Message, otherwise returns True. Returns an error, if the new score is not greater than the user's current score in the chat and force is False.
pub struct ConfigSetGameScore {
pub:
	user_id int //User identifier
	score int //New score, must be non-negative
	force bool //Pass True, if the high score is allowed to decrease. This can be useful when fixing mistakes or banning cheaters
	disable_edit_message bool //Pass True, if the game message should not be automatically edited to include the current scoreboard
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat
	message_id int //Required if inline_message_id is not specified. Identifier of the sent message
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
}
pub fn (d Bot) set_game_score(conf ConfigSetGameScore) Message {
	resp := d.http_request("setGameScore", json.encode(conf))
	return return_message(resp)
}

//GetGameHighScores Use this method to get data for high score tables. Will return the score of the specified user and several of their neighbors in a game. On success, returns an Array of GameHighScore objects.
pub struct ConfigGetGameHighScores {
pub:
	user_id int //Target user id
	chat_id string //Required if inline_message_id is not specified. Unique identifier for the target chat
	message_id int //Required if inline_message_id is not specified. Identifier of the sent message
	inline_message_id string //Required if chat_id and message_id are not specified. Identifier of the inline message
}
pub fn (d Bot) get_game_high_scores(conf ConfigGetGameHighScores) []GameHighScore {
	resp := d.http_request("getGameHighScores", json.encode(conf)) 
	return return_gamehighscores(resp)
}