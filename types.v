module vgram

pub struct Responser {
pub:
	ok bool                
	result string [raw]
	error_code int                 
	description string              
}

// This object represents an incoming update.At most one of the optional parameters can be present in any given update.
pub struct Update {
pub:
	update_id int // The update‘s unique identifier. Update identifiers start from a certain positive number and increase sequentially. This ID becomes especially handy if you’re using Webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order. If there are no new updates for at least a week, then identifier of the next update will be chosen randomly instead of sequentially.
	message Message // Optional. New incoming message of any kind — text, photo, sticker, etc.
	edited_message Message // Optional. New version of a message that is known to the bot and was edited
	channel_post Message // Optional. New incoming channel post of any kind — text, photo, sticker, etc.
	edited_channel_post Message // Optional. New version of a channel post that is known to the bot and was edited
	inline_query InlineQuery // Optional. New incoming inline query
	chosen_inline_result ChosenInlineResult // Optional. The result of an inline query that was chosen by a user and sent to their chat partner. Please see our documentation on the feedback collecting for details on how to enable these updates for your bot.
	callback_query CallbackQuery // Optional. New incoming callback query
	shipping_query ShippingQuery // Optional. New incoming shipping query. Only for invoices with flexible price
	pre_checkout_query PreCheckoutQuery // Optional. New incoming pre-checkout query. Contains full information about checkout
	poll Poll // Optional. New poll state. Bots receive only updates about stopped polls and polls, which are sent by the bot
}


// Contains information about the current status of a webhook.
pub struct WebhookInfo {
pub:
	url string // Webhook URL, may be empty if webhook is not set up
	has_custom_certificate bool // True, if a custom certificate was provided for webhook certificate checks
	pending_update_count int // Number of updates awaiting delivery
	last_error_date int // Optional. Unix time for the most recent error that happened when trying to deliver an update via webhook
	last_error_message string // Optional. Error message in human-readable format for the most recent error that happened when trying to deliver an update via webhook
	max_connections int // Optional. Maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery
	allowed_updates []string // Optional. A list of update types the bot is subscribed to. Defaults to all update types
}


// This object represents a Telegram user or bot.
pub struct User {
pub:
	id int // Unique identifier for this user or bot
	is_bot bool // True, if this user is a bot
	first_name string // User‘s or bot’s first name
	last_name string // Optional. User‘s or bot’s last name
	username string // Optional. User‘s or bot’s username
	language_code string // Optional. IETF language tag of the user's language
}


// This object represents a chat.
pub struct Chat {
pub:
	id int // Unique identifier for this chat. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
	@type string // Type of chat, can be either “private”, “group”, “supergroup” or “channel”
	title string // Optional. Title, for supergroups, channels and group chats
	username string // Optional. Username, for private chats, supergroups and channels if available
	first_name string // Optional. First name of the other party in a private chat
	last_name string // Optional. Last name of the other party in a private chat
	photo ChatPhoto // Optional. Chat photo. Returned only in getChat.
	description string // Optional. Description, for groups, supergroups and channel chats. Returned only in getChat.
	invite_link string // Optional. Chat invite link, for groups, supergroups and channel chats. Each administrator in a chat generates their own invite links, so the bot must first generate the link using exportChatInviteLink. Returned only in getChat.
	//pinned_message &Message // Optional. Pinned message, for groups, supergroups and channels. Returned only in getChat.
	permissions ChatPermissions // Optional. Default chat member permissions, for groups and supergroups. Returned only in getChat.
	sticker_set_name string // Optional. For supergroups, name of group sticker set. Returned only in getChat.
	can_set_sticker_set bool // Optional. True, if the bot can change the group sticker set. Returned only in getChat.
}


// This object represents a message.
pub struct Message {
pub:
	message_id int // Unique message identifier inside this chat
	from User // Optional. Sender, empty for messages sent to channels
	date int // Date the message was sent in Unix time
	chat Chat // Conversation the message belongs to
	forward_from User // Optional. For forwarded messages, sender of the original message
	forward_from_chat Chat // Optional. For messages forwarded from channels, information about the original channel
	forward_from_message_id int // Optional. For messages forwarded from channels, identifier of the original message in the channel
	forward_signature string // Optional. For messages forwarded from channels, signature of the post author if present
	forward_sender_name string // Optional. Sender's name for messages forwarded from users who disallow adding a link to their account in forwarded messages
	forward_date int // Optional. For forwarded messages, date the original message was sent in Unix time
	//reply_to_message &Message // Optional. For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
	edit_date int // Optional. Date the message was last edited in Unix time
	media_group_id string // Optional. The unique identifier of a media message group this message belongs to
	author_signature string // Optional. Signature of the post author for messages in channels
	text string // Optional. For text messages, the actual UTF-8 text of the message, 0-4096 characters.
	entities []MessageEntity // Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
	caption_entities []MessageEntity // Optional. For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption
	audio Audio // Optional. Message is an audio file, information about the file
	document Document // Optional. Message is a general file, information about the file
	animation Animation // Optional. Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set
	game Game // Optional. Message is a game, information about the game. More about games »
	photo []PhotoSize // Optional. Message is a photo, available sizes of the photo
	sticker Sticker // Optional. Message is a sticker, information about the sticker
	video Video // Optional. Message is a video, information about the video
	voice Voice // Optional. Message is a voice message, information about the file
	video_note VideoNote // Optional. Message is a video note, information about the video message
	caption string // Optional. Caption for the animation, audio, document, photo, video or voice, 0-1024 characters
	contact Contact // Optional. Message is a shared contact, information about the contact
	location Location // Optional. Message is a shared location, information about the location
	venue Venue // Optional. Message is a venue, information about the venue
	poll Poll // Optional. Message is a native poll, information about the poll
	new_chat_members []User // Optional. New members that were added to the group or supergroup and information about them (the bot itself may be one of these members)
	left_chat_member User // Optional. A member was removed from the group, information about them (this member may be the bot itself)
	new_chat_title string // Optional. A chat title was changed to this value
	new_chat_photo []PhotoSize // Optional. A chat photo was change to this value
	delete_chat_photo bool // Optional. Service message: the chat photo was deleted
	group_chat_created bool // Optional. Service message: the group has been created
	supergroup_chat_created bool // Optional. Service message: the supergroup has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
	channel_chat_created bool // Optional. Service message: the channel has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
	migrate_to_chat_id int // Optional. The group has been migrated to a supergroup with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
	migrate_from_chat_id int // Optional. The supergroup has been migrated from a group with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
	//pinned_message &Message // Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it is itself a reply.
	invoice Invoice // Optional. Message is an invoice for a payment, information about the invoice. More about payments »
	successful_payment SuccessfulPayment // Optional. Message is a service message about a successful payment, information about the payment. More about payments »
	connected_website string // Optional. The domain name of the website on which the user has logged in. More about Telegram Login »
	passport_data PassportData // Optional. Telegram Passport data
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message. login_url buttons are represented as ordinary url buttons.
}


// This object represents one special entity in a text message. For example, hashtags, usernames, URLs, etc.
pub struct MessageEntity {
pub:
	@type string // Type of the entity. Can be mention (@username), hashtag, cashtag, bot_command, url, email, phone_number, bold (bold text), italic (italic text), code (monowidth string), pre (monowidth block), text_link (for clickable text URLs), text_mention (for users without usernames)
	offset int // Offset in UTF-16 code units to the start of the entity
	length int // Length of the entity in UTF-16 code units
	url string // Optional. For “text_link” only, url that will be opened after user taps on the text
	user User // Optional. For “text_mention” only, the mentioned user
}


// This object represents one size of a photo or a file / sticker thumbnail.
pub struct PhotoSize {
pub:
	file_id string // Identifier for this file
	width int // Photo width
	height int // Photo height
	file_size int // Optional. File size
}


// This object represents an audio file to be treated as music by the Telegram clients.
pub struct Audio {
pub:
	file_id string // Identifier for this file
	duration int // Duration of the audio in seconds as defined by sender
	performer string // Optional. Performer of the audio as defined by sender or by audio tags
	title string // Optional. Title of the audio as defined by sender or by audio tags
	mime_type string // Optional. MIME type of the file as defined by sender
	file_size int // Optional. File size
	thumb PhotoSize // Optional. Thumbnail of the album cover to which the music file belongs
}


// This object represents a general file (as opposed to photos, voice messages and audio files).
pub struct Document {
pub:
	file_id string // Identifier for this file
	thumb PhotoSize // Optional. Document thumbnail as defined by sender
	file_name string // Optional. Original filename as defined by sender
	mime_type string // Optional. MIME type of the file as defined by sender
	file_size int // Optional. File size
}


// This object represents a video file.
pub struct Video {
pub:
	file_id string // Identifier for this file
	width int // Video width as defined by sender
	height int // Video height as defined by sender
	duration int // Duration of the video in seconds as defined by sender
	thumb PhotoSize // Optional. Video thumbnail
	mime_type string // Optional. Mime type of a file as defined by sender
	file_size int // Optional. File size
}


// This object represents an animation file (GIF or H.264/MPEG-4 AVC video without sound).
pub struct Animation {
pub:
	file_id string // Identifier for this file
	width int // Video width as defined by sender
	height int // Video height as defined by sender
	duration int // Duration of the video in seconds as defined by sender
	thumb PhotoSize // Optional. Animation thumbnail as defined by sender
	file_name string // Optional. Original animation filename as defined by sender
	mime_type string // Optional. MIME type of the file as defined by sender
	file_size int // Optional. File size
}


// This object represents a voice note.
pub struct Voice {
pub:
	file_id string // Identifier for this file
	duration int // Duration of the audio in seconds as defined by sender
	mime_type string // Optional. MIME type of the file as defined by sender
	file_size int // Optional. File size
}


// This object represents a video message (available in Telegram apps as of v.4.0).
pub struct VideoNote {
pub:
	file_id string // Identifier for this file
	length int // Video width and height (diameter of the video message) as defined by sender
	duration int // Duration of the video in seconds as defined by sender
	thumb PhotoSize // Optional. Video thumbnail
	file_size int // Optional. File size
}


// This object represents a phone contact.
pub struct Contact {
pub:
	phone_number string // Contact's phone number
	first_name string // Contact's first name
	last_name string // Optional. Contact's last name
	user_id int // Optional. Contact's user identifier in Telegram
	vcard string // Optional. Additional data about the contact in the form of a vCard
}


// This object represents a point on the map.
pub struct Location {
pub:
	longitude f32 // Longitude as defined by sender
	latitude f32 // Latitude as defined by sender
}


// This object represents a venue.
pub struct Venue {
pub:
	location Location // Venue location
	title string // Name of the venue
	address string // Address of the venue
	foursquare_id string // Optional. Foursquare identifier of the venue
	foursquare_type string // Optional. Foursquare type of the venue. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
}


// This object contains information about one answer option in a poll.
pub struct PollOption {
pub:
	text string // Option text, 1-100 characters
	voter_count int // Number of users that voted for this option
}


// This object contains information about a poll.
pub struct Poll {
pub:
	id string // Unique poll identifier
	question string // Poll question, 1-255 characters
	options []PollOption // List of poll options
	is_closed bool // True, if the poll is closed
}


// This object represent a user&#39;s profile pictures.
pub struct UserProfilePhotos {
pub:
	total_count int // Total number of profile pictures the target user has
	photos [][]PhotoSize // Requested profile pictures (in up to 4 sizes each)
}


// This object represents a file ready to be downloaded. The file can be downloaded via the link https://api.telegram.org/file/bot&lt;token&gt;/&lt;file_path&gt;. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile.
pub struct File {
pub:
	file_id string // Identifier for this file
	file_size int // Optional. File size, if known
	file_path string // Optional. File path. Use https://api.telegram.org/file/bot<token>/<file_path> to get the file.
}


// This object represents a custom keyboard with reply options (see Introduction to bots for details and examples).
pub struct ReplyKeyboardMarkup {
pub:
	keyboard [][]KeyboardButton // Array of button rows, each represented by an Array of KeyboardButton objects
	resize_keyboard bool // Optional. Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
	one_time_keyboard bool // Optional. Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat – the user can press a special button in the input field to see the custom keyboard again. Defaults to false.
	selective bool // Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.Example: A user requests to change the bot‘s language, bot replies to the request with a keyboard to select the new language. Other users in the group don’t see the keyboard.
}


// This object represents one button of the reply keyboard. For simple text buttons String can be used instead of this object to specify text of the button. Optional fields are mutually exclusive.
pub struct KeyboardButton {
pub:
	text string // Text of the button. If none of the optional fields are used, it will be sent as a message when the button is pressed
	request_contact bool // Optional. If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only
	request_location bool // Optional. If True, the user's current location will be sent when the button is pressed. Available in private chats only
}


// Upon receiving a message with this object, Telegram clients will remove the current custom keyboard and display the default letter-keyboard. By default, custom keyboards are displayed until a new keyboard is sent by a bot. An exception is made for one-time keyboards that are hidden immediately after the user presses a button (see ReplyKeyboardMarkup).
pub struct ReplyKeyboardRemove {
pub:
	remove_keyboard bool // Requests clients to remove the custom keyboard (user will not be able to summon this keyboard; if you want to hide the keyboard from sight but keep it accessible, use one_time_keyboard in ReplyKeyboardMarkup)
	selective bool // Optional. Use this parameter if you want to remove the keyboard for specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.Example: A user votes in a poll, bot returns confirmation message in reply to the vote and removes the keyboard for that user, while still showing the keyboard with poll options to users who haven't voted yet.
}


// This object represents an inline keyboard that appears right next to the message it belongs to.
pub struct InlineKeyboardMarkup {
pub:
	inline_keyboard [][]InlineKeyboardButton // Array of button rows, each represented by an Array of InlineKeyboardButton objects
}


// This object represents one button of an inline keyboard. You must use exactly one of the optional fields.
pub struct InlineKeyboardButton {
pub:
	text string // Label text on the button
	url string // Optional. HTTP or tg:// url to be opened when button is pressed
	login_url LoginUrl // Optional. An HTTP URL used to automatically authorize the user. Can be used as a replacement for the Telegram Login Widget.
	callback_data string // Optional. Data to be sent in a callback query to the bot when button is pressed, 1-64 bytes
	switch_inline_query string // Optional. If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot‘s username and the specified inline query in the input field. Can be empty, in which case just the bot’s username will be inserted.Note: This offers an easy way for users to start using your bot in inline mode when they are currently in a private chat with it. Especially useful when combined with switch_pm… actions – in this case the user will be automatically returned to the chat they switched from, skipping the chat selection screen.
	switch_inline_query_current_chat string // Optional. If set, pressing the button will insert the bot‘s username and the specified inline query in the current chat's input field. Can be empty, in which case only the bot’s username will be inserted.This offers a quick way for the user to open your bot in inline mode in the same chat – good for selecting something from multiple options.
	callback_game CallbackGame // Optional. Description of the game that will be launched when the user presses the button.NOTE: This type of button must always be the first button in the first row.
	pay bool // Optional. Specify True, to send a Pay button.NOTE: This type of button must always be the first button in the first row.
}


// This object represents a parameter of the inline keyboard button used to automatically authorize a user. Serves as a great replacement for the Telegram Login Widget when the user is coming from Telegram. All the user needs to do is tap/click a button and confirm that they want to log in:
pub struct LoginUrl {
pub:
	url string // An HTTP URL to be opened with user authorization data added to the query string when the button is pressed. If the user refuses to provide authorization data, the original URL without information about the user will be opened. The data added is the same as described in Receiving authorization data.NOTE: You must always check the hash of the received data to verify the authentication and the integrity of the data as described in Checking authorization.
	forward_text string // Optional. New text of the button in forwarded messages.
	bot_username string // Optional. Username of a bot, which will be used for user authorization. See Setting up a bot for more details. If not specified, the current bot's username will be assumed. The url's domain must be the same as the domain linked with the bot. See Linking your domain to the bot for more details.
	request_write_access bool // Optional. Pass True to request the permission for your bot to send messages to the user.
}


// This object represents an incoming callback query from a callback button in an inline keyboard. If the button that originated the query was attached to a message sent by the bot, the field message will be present. If the button was attached to a message sent via the bot (in inline mode), the field inline_message_id will be present. Exactly one of the fields data or game_short_name will be present.
pub struct CallbackQuery {
pub:
	id string // Unique identifier for this query
	from User // Sender
	message Message // Optional. Message with the callback button that originated the query. Note that message content and message date will not be available if the message is too old
	inline_message_id string // Optional. Identifier of the message sent via the bot in inline mode, that originated the query.
	chat_instance string // Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent. Useful for high scores in games.
	data string // Optional. Data associated with the callback button. Be aware that a bad client can send arbitrary data in this field.
	game_short_name string // Optional. Short name of a Game to be returned, serves as the unique identifier for the game
}


// Upon receiving a message with this object, Telegram clients will display a reply interface to the user (act as if the user has selected the bot‘s message and tapped ’Reply&#39;). This can be extremely useful if you want to create user-friendly step-by-step interfaces without having to sacrifice privacy mode.
pub struct ForceReply {
pub:
	force_reply bool // Shows reply interface to the user, as if they manually selected the bot‘s message and tapped ’Reply'
	selective bool // Optional. Use this parameter if you want to force reply from specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
}


// This object represents a chat photo.
pub struct ChatPhoto {
pub:
	small_file_id string // File identifier of small (160x160) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.
	big_file_id string // File identifier of big (640x640) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.
}


// This object contains information about one member of a chat.
pub struct ChatMember {
pub:
	user User // Information about the user
	status string // The member's status in the chat. Can be “creator”, “administrator”, “member”, “restricted”, “left” or “kicked”
	until_date int // Optional. Restricted and kicked only. Date when restrictions will be lifted for this user; unix time
	can_be_edited bool // Optional. Administrators only. True, if the bot is allowed to edit administrator privileges of that user
	can_post_messages bool // Optional. Administrators only. True, if the administrator can post in the channel; channels only
	can_edit_messages bool // Optional. Administrators only. True, if the administrator can edit messages of other users and can pin messages; channels only
	can_delete_messages bool // Optional. Administrators only. True, if the administrator can delete messages of other users
	can_restrict_members bool // Optional. Administrators only. True, if the administrator can restrict, ban or unban chat members
	can_promote_members bool // Optional. Administrators only. True, if the administrator can add new administrators with a subset of his own privileges or demote administrators that he has promoted, directly or indirectly (promoted by administrators that were appointed by the user)
	can_change_info bool // Optional. Administrators and restricted only. True, if the user is allowed to change the chat title, photo and other settings
	can_invite_users bool // Optional. Administrators and restricted only. True, if the user is allowed to invite new users to the chat
	can_pin_messages bool // Optional. Administrators and restricted only. True, if the user is allowed to pin messages; groups and supergroups only
	is_member bool // Optional. Restricted only. True, if the user is a member of the chat at the moment of the request
	can_send_messages bool // Optional. Restricted only. True, if the user is allowed to send text messages, contacts, locations and venues
	can_send_media_messages bool // Optional. Restricted only. True, if the user is allowed to send audios, documents, photos, videos, video notes and voice notes
	can_send_polls bool // Optional. Restricted only. True, if the user is allowed to send polls
	can_send_other_messages bool // Optional. Restricted only. True, if the user is allowed to send animations, games, stickers and use inline bots
	can_add_web_page_previews bool // Optional. Restricted only. True, if the user is allowed to add web page previews to their messages
}


// Describes actions that a non-administrator user is allowed to take in a chat.
pub struct ChatPermissions {
pub:
	can_send_messages bool // Optional. True, if the user is allowed to send text messages, contacts, locations and venues
	can_send_media_messages bool // Optional. True, if the user is allowed to send audios, documents, photos, videos, video notes and voice notes, implies can_send_messages
	can_send_polls bool // Optional. True, if the user is allowed to send polls, implies can_send_messages
	can_send_other_messages bool // Optional. True, if the user is allowed to send animations, games, stickers and use inline bots, implies can_send_media_messages
	can_add_web_page_previews bool // Optional. True, if the user is allowed to add web page previews to their messages, implies can_send_media_messages
	can_change_info bool // Optional. True, if the user is allowed to change the chat title, photo and other settings. Ignored in public supergroups
	can_invite_users bool // Optional. True, if the user is allowed to invite new users to the chat
	can_pin_messages bool // Optional. True, if the user is allowed to pin messages. Ignored in public supergroups
}


// Contains information about why a request was unsuccessful.
pub struct ResponseParameters {
pub:
	migrate_to_chat_id int // Optional. The group has been migrated to a supergroup with the specified identifier. This number may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.
	retry_after int // Optional. In case of exceeding flood control, the number of seconds left to wait before the request can be repeated
}


// This object represents the content of a media message to be sent. It should be one of
pub struct InputMedia {
pub:
	@type string // Type of the result, must be photo
	media string // File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	caption string // Optional. Caption of the photo to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
}


// Represents a photo to be sent.
pub struct InputMediaPhoto {
pub:
	@type string // Type of the result, must be photo
	media string // File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	caption string // Optional. Caption of the photo to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
}


// Represents a video to be sent.
pub struct InputMediaVideo {
pub:
	@type string // Type of the result, must be video
	media string // File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	thumb string // Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string // Optional. Caption of the video to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	width int // Optional. Video width
	height int // Optional. Video height
	duration int // Optional. Video duration
	supports_streaming bool // Optional. Pass True, if the uploaded video is suitable for streaming
}


// Represents an animation file (GIF or H.264/MPEG-4 AVC video without sound) to be sent.
pub struct InputMediaAnimation {
pub:
	@type string // Type of the result, must be animation
	media string // File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	thumb string // Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string // Optional. Caption of the animation to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	width int // Optional. Animation width
	height int // Optional. Animation height
	duration int // Optional. Animation duration
}


// Represents an audio file to be treated as music to be sent.
pub struct InputMediaAudio {
pub:
	@type string // Type of the result, must be audio
	media string // File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	thumb string // Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string // Optional. Caption of the audio to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	duration int // Optional. Duration of the audio in seconds
	performer string // Optional. Performer of the audio
	title string // Optional. Title of the audio
}


// Represents a general file to be sent.
pub struct InputMediaDocument {
pub:
	@type string // Type of the result, must be document
	media string // File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	thumb string // Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail‘s width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	caption string // Optional. Caption of the document to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
}


// This object represents the contents of a file to be uploaded. Must be posted using multipart/form-data in the usual way that files are uploaded via the browser.
pub struct InputFile {
pub:
	chat_id string // Yes
	text string // Yes
	parse_mode string // Optional
	disable_web_page_preview bool // Optional
	disable_notification bool // Optional
	reply_to_message_id int // Optional
	reply_markup string //TODO: fix here Optional
}


// This object represents a sticker.
pub struct Sticker {
pub:
	file_id string // Identifier for this file
	width int // Sticker width
	height int // Sticker height
	is_animated bool // True, if the sticker is animated
	thumb PhotoSize // Optional. Sticker thumbnail in the .webp or .jpg format
	emoji string // Optional. Emoji associated with the sticker
	set_name string // Optional. Name of the sticker set to which the sticker belongs
	mask_position MaskPosition // Optional. For mask stickers, the position where the mask should be placed
	file_size int // Optional. File size
}


// This object represents a sticker set.
pub struct StickerSet {
pub:
	name string // Sticker set name
	title string // Sticker set title
	is_animated bool // True, if the sticker set contains animated stickers
	contains_masks bool // True, if the sticker set contains masks
	stickers []Sticker // List of all set stickers
}


// This object describes the position on faces where a mask should be placed by default.
pub struct MaskPosition {
pub:
	point string // The part of the face relative to which the mask should be placed. One of “forehead”, “eyes”, “mouth”, or “chin”.
	x_shift f32 // Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position.
	y_shift f32 // Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position.
	scale f32 // Mask scaling coefficient. For example, 2.0 means double size.
}


// This object represents an incoming inline query. When the user sends an empty query, your bot could return some default or trending results.
pub struct InlineQuery {
pub:
	id string // Unique identifier for this query
	from User // Sender
	location Location // Optional. Sender location, only for bots that request user location
	query string // Text of the query (up to 512 characters)
	offset string // Offset of the results to be returned, can be controlled by the bot
}


// This object represents one result of an inline query. Telegram clients currently support results of the following 20 types:
pub struct InlineQueryResult {
pub:
	@type string // Type of the result, must be article
	id string // Unique identifier for this result, 1-64 Bytes
	title string // Title of the result
	input_message_content InputMessageContent // Content of the message to be sent
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	url string // Optional. URL of the result
	hide_url bool // Optional. Pass True, if you don't want the URL to be shown in the message
	description string // Optional. Short description of the result
	thumb_url string // Optional. Url of the thumbnail for the result
	thumb_width int // Optional. Thumbnail width
	thumb_height int // Optional. Thumbnail height
}


// Represents a link to an article or web page.
pub struct InlineQueryResultArticle {
pub:
	@type string // Type of the result, must be article
	id string // Unique identifier for this result, 1-64 Bytes
	title string // Title of the result
	input_message_content InputMessageContent // Content of the message to be sent
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	url string // Optional. URL of the result
	hide_url bool // Optional. Pass True, if you don't want the URL to be shown in the message
	description string // Optional. Short description of the result
	thumb_url string // Optional. Url of the thumbnail for the result
	thumb_width int // Optional. Thumbnail width
	thumb_height int // Optional. Thumbnail height
}


// Represents a link to a photo. By default, this photo will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.
pub struct InlineQueryResultPhoto {
pub:
	@type string // Type of the result, must be photo
	id string // Unique identifier for this result, 1-64 bytes
	photo_url string // A valid URL of the photo. Photo must be in jpeg format. Photo size must not exceed 5MB
	thumb_url string // URL of the thumbnail for the photo
	photo_width int // Optional. Width of the photo
	photo_height int // Optional. Height of the photo
	title string // Optional. Title for the result
	description string // Optional. Short description of the result
	caption string // Optional. Caption of the photo to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the photo
}


// Represents a link to an animated GIF file. By default, this animated GIF file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.
pub struct InlineQueryResultGif {
pub:
	@type string // Type of the result, must be gif
	id string // Unique identifier for this result, 1-64 bytes
	gif_url string // A valid URL for the GIF file. File size must not exceed 1MB
	gif_width int // Optional. Width of the GIF
	gif_height int // Optional. Height of the GIF
	gif_duration int // Optional. Duration of the GIF
	thumb_url string // URL of the static thumbnail for the result (jpeg or gif)
	title string // Optional. Title for the result
	caption string // Optional. Caption of the GIF file to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the GIF animation
}


// Represents a link to a video animation (H.264/MPEG-4 AVC video without sound). By default, this animated MPEG-4 file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.
pub struct InlineQueryResultMpeg4Gif {
pub:
	@type string // Type of the result, must be mpeg4_gif
	id string // Unique identifier for this result, 1-64 bytes
	mpeg4_url string // A valid URL for the MP4 file. File size must not exceed 1MB
	mpeg4_width int // Optional. Video width
	mpeg4_height int // Optional. Video height
	mpeg4_duration int // Optional. Video duration
	thumb_url string // URL of the static thumbnail (jpeg or gif) for the result
	title string // Optional. Title for the result
	caption string // Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the video animation
}


// Represents a link to a page containing an embedded video player or a video file. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.
pub struct InlineQueryResultVideo {
pub:
	@type string // Type of the result, must be video
	id string // Unique identifier for this result, 1-64 bytes
	video_url string // A valid URL for the embedded video player or video file
	mime_type string // Mime type of the content of video url, “text/html” or “video/mp4”
	thumb_url string // URL of the thumbnail (jpeg only) for the video
	title string // Title for the result
	caption string // Optional. Caption of the video to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	video_width int // Optional. Video width
	video_height int // Optional. Video height
	video_duration int // Optional. Video duration in seconds
	description string // Optional. Short description of the result
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the video. This field is required if InlineQueryResultVideo is used to send an HTML-page as a result (e.g., a YouTube video).
}


// Represents a link to an mp3 audio file. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.
pub struct InlineQueryResultAudio {
pub:
	@type string // Type of the result, must be audio
	id string // Unique identifier for this result, 1-64 bytes
	audio_url string // A valid URL for the audio file
	title string // Title
	caption string // Optional. Caption, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	performer string // Optional. Performer
	audio_duration int // Optional. Audio duration in seconds
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the audio
}


// Represents a link to a voice recording in an .ogg container encoded with OPUS. By default, this voice recording will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the the voice message.
pub struct InlineQueryResultVoice {
pub:
	@type string // Type of the result, must be voice
	id string // Unique identifier for this result, 1-64 bytes
	voice_url string // A valid URL for the voice recording
	title string // Recording title
	caption string // Optional. Caption, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	voice_duration int // Optional. Recording duration in seconds
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the voice recording
}


// Represents a link to a file. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file. Currently, only .PDF and .ZIP files can be sent using this method.
pub struct InlineQueryResultDocument {
pub:
	@type string // Type of the result, must be document
	id string // Unique identifier for this result, 1-64 bytes
	title string // Title for the result
	caption string // Optional. Caption of the document to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	document_url string // A valid URL for the file
	mime_type string // Mime type of the content of the file, either “application/pdf” or “application/zip”
	description string // Optional. Short description of the result
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the file
	thumb_url string // Optional. URL of the thumbnail (jpeg only) for the file
	thumb_width int // Optional. Thumbnail width
	thumb_height int // Optional. Thumbnail height
}


// Represents a location on a map. By default, the location will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the location.
pub struct InlineQueryResultLocation {
pub:
	@type string // Type of the result, must be location
	id string // Unique identifier for this result, 1-64 Bytes
	latitude f32 // Location latitude in degrees
	longitude f32 // Location longitude in degrees
	title string // Location title
	live_period int // Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the location
	thumb_url string // Optional. Url of the thumbnail for the result
	thumb_width int // Optional. Thumbnail width
	thumb_height int // Optional. Thumbnail height
}


// Represents a venue. By default, the venue will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the venue.
pub struct InlineQueryResultVenue {
pub:
	@type string // Type of the result, must be venue
	id string // Unique identifier for this result, 1-64 Bytes
	latitude f32 // Latitude of the venue location in degrees
	longitude f32 // Longitude of the venue location in degrees
	title string // Title of the venue
	address string // Address of the venue
	foursquare_id string // Optional. Foursquare identifier of the venue if known
	foursquare_type string // Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the venue
	thumb_url string // Optional. Url of the thumbnail for the result
	thumb_width int // Optional. Thumbnail width
	thumb_height int // Optional. Thumbnail height
}


// Represents a contact with a phone number. By default, this contact will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the contact.
pub struct InlineQueryResultContact {
pub:
	@type string // Type of the result, must be contact
	id string // Unique identifier for this result, 1-64 Bytes
	phone_number string // Contact's phone number
	first_name string // Contact's first name
	last_name string // Optional. Contact's last name
	vcard string // Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the contact
	thumb_url string // Optional. Url of the thumbnail for the result
	thumb_width int // Optional. Thumbnail width
	thumb_height int // Optional. Thumbnail height
}


// Represents a Game.
pub struct InlineQueryResultGame {
pub:
	@type string // Type of the result, must be game
	id string // Unique identifier for this result, 1-64 bytes
	game_short_name string // Short name of the game
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
}


// Represents a link to a photo stored on the Telegram servers. By default, this photo will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.
pub struct InlineQueryResultCachedPhoto {
pub:
	@type string // Type of the result, must be photo
	id string // Unique identifier for this result, 1-64 bytes
	photo_file_id string // A valid file identifier of the photo
	title string // Optional. Title for the result
	description string // Optional. Short description of the result
	caption string // Optional. Caption of the photo to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the photo
}


// Represents a link to an animated GIF file stored on the Telegram servers. By default, this animated GIF file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with specified content instead of the animation.
pub struct InlineQueryResultCachedGif {
pub:
	@type string // Type of the result, must be gif
	id string // Unique identifier for this result, 1-64 bytes
	gif_file_id string // A valid file identifier for the GIF file
	title string // Optional. Title for the result
	caption string // Optional. Caption of the GIF file to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the GIF animation
}


// Represents a link to a video animation (H.264/MPEG-4 AVC video without sound) stored on the Telegram servers. By default, this animated MPEG-4 file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.
pub struct InlineQueryResultCachedMpeg4Gif {
pub:
	@type string // Type of the result, must be mpeg4_gif
	id string // Unique identifier for this result, 1-64 bytes
	mpeg4_file_id string // A valid file identifier for the MP4 file
	title string // Optional. Title for the result
	caption string // Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the video animation
}


// Represents a link to a sticker stored on the Telegram servers. By default, this sticker will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the sticker.
pub struct InlineQueryResultCachedSticker {
pub:
	@type string // Type of the result, must be sticker
	id string // Unique identifier for this result, 1-64 bytes
	sticker_file_id string // A valid file identifier of the sticker
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the sticker
}


// Represents a link to a file stored on the Telegram servers. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file.
pub struct InlineQueryResultCachedDocument {
pub:
	@type string // Type of the result, must be document
	id string // Unique identifier for this result, 1-64 bytes
	title string // Title for the result
	document_file_id string // A valid file identifier for the file
	description string // Optional. Short description of the result
	caption string // Optional. Caption of the document to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the file
}


// Represents a link to a video file stored on the Telegram servers. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.
pub struct InlineQueryResultCachedVideo {
pub:
	@type string // Type of the result, must be video
	id string // Unique identifier for this result, 1-64 bytes
	video_file_id string // A valid file identifier for the video file
	title string // Title for the result
	description string // Optional. Short description of the result
	caption string // Optional. Caption of the video to be sent, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the video
}


// Represents a link to a voice message stored on the Telegram servers. By default, this voice message will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the voice message.
pub struct InlineQueryResultCachedVoice {
pub:
	@type string // Type of the result, must be voice
	id string // Unique identifier for this result, 1-64 bytes
	voice_file_id string // A valid file identifier for the voice message
	title string // Voice message title
	caption string // Optional. Caption, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the voice message
}


// Represents a link to an mp3 audio file stored on the Telegram servers. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.
pub struct InlineQueryResultCachedAudio {
pub:
	@type string // Type of the result, must be audio
	id string // Unique identifier for this result, 1-64 bytes
	audio_file_id string // A valid file identifier for the audio file
	caption string // Optional. Caption, 0-1024 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
	reply_markup InlineKeyboardMarkup // Optional. Inline keyboard attached to the message
	input_message_content InputMessageContent // Optional. Content of the message to be sent instead of the audio
}


// This object represents the content of a message to be sent as a result of an inline query. Telegram clients currently support the following 4 types:
pub struct InputMessageContent {
pub:
	message_text string // Text of the message to be sent, 1-4096 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
	disable_web_page_preview bool // Optional. Disables link previews for links in the sent message
}


// Represents the content of a text message to be sent as the result of an inline query.
pub struct InputTextMessageContent {
pub:
	message_text string // Text of the message to be sent, 1-4096 characters
	parse_mode string // Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
	disable_web_page_preview bool // Optional. Disables link previews for links in the sent message
}


// Represents the content of a location message to be sent as the result of an inline query.
pub struct InputLocationMessageContent {
pub:
	latitude f32 // Latitude of the location in degrees
	longitude f32 // Longitude of the location in degrees
	live_period int // Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.
}


// Represents the content of a venue message to be sent as the result of an inline query.
pub struct InputVenueMessageContent {
pub:
	latitude f32 // Latitude of the venue in degrees
	longitude f32 // Longitude of the venue in degrees
	title string // Name of the venue
	address string // Address of the venue
	foursquare_id string // Optional. Foursquare identifier of the venue, if known
	foursquare_type string // Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
}


// Represents the content of a contact message to be sent as the result of an inline query.
pub struct InputContactMessageContent {
pub:
	phone_number string // Contact's phone number
	first_name string // Contact's first name
	last_name string // Optional. Contact's last name
	vcard string // Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes
}


// Represents a result of an inline query that was chosen by the user and sent to their chat partner.
pub struct ChosenInlineResult {
pub:
	result_id string // The unique identifier for the result that was chosen
	from User // The user that chose the result
	location Location // Optional. Sender location, only for bots that require user location
	inline_message_id string // Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message. Will be also received in callback queries and can be used to edit the message.
	query string // The query that was used to obtain the result
}


// This object represents a portion of the price for goods or services.
pub struct LabeledPrice {
pub:
	label string // Portion label
	amount int // Price of the product in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
}


// This object contains basic information about an invoice.
pub struct Invoice {
pub:
	title string // Product name
	description string // Product description
	start_parameter string // Unique bot deep-linking parameter that can be used to generate this invoice
	currency string // Three-letter ISO 4217 currency code
	total_amount int // Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
}


// This object represents a shipping address.
pub struct ShippingAddress {
pub:
	country_code string // ISO 3166-1 alpha-2 country code
	state string // State, if applicable
	city string // City
	street_line1 string // First line for the address
	street_line2 string // Second line for the address
	post_code string // Address post code
}


// This object represents information about an order.
pub struct OrderInfo {
pub:
	name string // Optional. User name
	phone_number string // Optional. User's phone number
	email string // Optional. User email
	shipping_address ShippingAddress // Optional. User shipping address
}


// This object represents one shipping option.
pub struct ShippingOption {
pub:
	id string // Shipping option identifier
	title string // Option title
	prices []LabeledPrice // List of price portions
}


// This object contains basic information about a successful payment.
pub struct SuccessfulPayment {
pub:
	currency string // Three-letter ISO 4217 currency code
	total_amount int // Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
	invoice_payload string // Bot specified invoice payload
	shipping_option_id string // Optional. Identifier of the shipping option chosen by the user
	order_info OrderInfo // Optional. Order info provided by the user
	telegram_payment_charge_id string // Telegram payment identifier
	provider_payment_charge_id string // Provider payment identifier
}


// This object contains information about an incoming shipping query.
pub struct ShippingQuery {
pub:
	id string // Unique query identifier
	from User // User who sent the query
	invoice_payload string // Bot specified invoice payload
	shipping_address ShippingAddress // User specified shipping address
}


// This object contains information about an incoming pre-checkout query.
pub struct PreCheckoutQuery {
pub:
	id string // Unique query identifier
	from User // User who sent the query
	currency string // Three-letter ISO 4217 currency code
	total_amount int // Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
	invoice_payload string // Bot specified invoice payload
	shipping_option_id string // Optional. Identifier of the shipping option chosen by the user
	order_info OrderInfo // Optional. Order info provided by the user
}


// Contains information about Telegram Passport data shared with the bot by the user.
pub struct PassportData {
pub:
	data []EncryptedPassportElement // Array with information about documents and other Telegram Passport elements that was shared with the bot
	credentials EncryptedCredentials // Encrypted credentials required to decrypt the data
}


// This object represents a file uploaded to Telegram Passport. Currently all Telegram Passport files are in JPEG format when decrypted and don&#39;t exceed 10MB.
pub struct PassportFile {
pub:
	file_id string // Identifier for this file
	file_size int // File size
	file_date int // Unix time when the file was uploaded
}


// Contains information about documents or other Telegram Passport elements shared with the bot by the user.
pub struct EncryptedPassportElement {
pub:
	@type string // Element type. One of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”, “phone_number”, “email”.
	data string // Optional. Base64-encoded encrypted Telegram Passport element data provided by the user, available for “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport” and “address” types. Can be decrypted and verified using the accompanying EncryptedCredentials.
	phone_number string // Optional. User's verified phone number, available only for “phone_number” type
	email string // Optional. User's verified email address, available only for “email” type
	files []PassportFile // Optional. Array of encrypted files with documents provided by the user, available for “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.
	front_side PassportFile // Optional. Encrypted file with the front side of the document, provided by the user. Available for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.
	reverse_side PassportFile // Optional. Encrypted file with the reverse side of the document, provided by the user. Available for “driver_license” and “identity_card”. The file can be decrypted and verified using the accompanying EncryptedCredentials.
	selfie PassportFile // Optional. Encrypted file with the selfie of the user holding a document, provided by the user; available for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.
	translation []PassportFile // Optional. Array of encrypted files with translated versions of documents provided by the user. Available if requested for “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.
	hash string // Base64-encoded element hash for using in PassportElementErrorUnspecified
}


// Contains data required for decrypting and authenticating EncryptedPassportElement. See the Telegram Passport Documentation for a complete description of the data decryption and authentication processes.
pub struct EncryptedCredentials {
pub:
	data string // Base64-encoded encrypted JSON-serialized data with unique user's payload, data hashes and secrets required for EncryptedPassportElement decryption and authentication
	hash string // Base64-encoded data hash for data authentication
	secret string // Base64-encoded secret, encrypted with the bot's public RSA key, required for data decryption
}


// This object represents an error in the Telegram Passport element which was submitted that should be resolved by the user. It should be one of:
pub struct PassportElementError {
pub:
	source string // Error source, must be data
	@type string // The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”
	field_name string // Name of the data field which has the error
	data_hash string // Base64-encoded data hash
	message string // Error message
}


// Represents an issue in one of the data fields that was provided by the user. The error is considered resolved when the field&#39;s value changes.
pub struct PassportElementErrorDataField {
pub:
	source string // Error source, must be data
	@type string // The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”
	field_name string // Name of the data field which has the error
	data_hash string // Base64-encoded data hash
	message string // Error message
}


// Represents an issue with the front side of a document. The error is considered resolved when the file with the front side of the document changes.
pub struct PassportElementErrorFrontSide {
pub:
	source string // Error source, must be front_side
	@type string // The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”
	file_hash string // Base64-encoded hash of the file with the front side of the document
	message string // Error message
}


// Represents an issue with the reverse side of a document. The error is considered resolved when the file with reverse side of the document changes.
pub struct PassportElementErrorReverseSide {
pub:
	source string // Error source, must be reverse_side
	@type string // The section of the user's Telegram Passport which has the issue, one of “driver_license”, “identity_card”
	file_hash string // Base64-encoded hash of the file with the reverse side of the document
	message string // Error message
}


// Represents an issue with the selfie with a document. The error is considered resolved when the file with the selfie changes.
pub struct PassportElementErrorSelfie {
pub:
	source string // Error source, must be selfie
	@type string // The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”
	file_hash string // Base64-encoded hash of the file with the selfie
	message string // Error message
}


// Represents an issue with a document scan. The error is considered resolved when the file with the document scan changes.
pub struct PassportElementErrorFile {
pub:
	source string // Error source, must be file
	@type string // The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	file_hash string // Base64-encoded file hash
	message string // Error message
}


// Represents an issue with a list of scans. The error is considered resolved when the list of files containing the scans changes.
pub struct PassportElementErrorFiles {
pub:
	source string // Error source, must be files
	@type string // The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	file_hashes []string // List of base64-encoded file hashes
	message string // Error message
}


// Represents an issue with one of the files that constitute the translation of a document. The error is considered resolved when the file changes.
pub struct PassportElementErrorTranslationFile {
pub:
	source string // Error source, must be translation_file
	@type string // Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	file_hash string // Base64-encoded file hash
	message string // Error message
}


// Represents an issue with the translated version of a document. The error is considered resolved when a file with the document translation change.
pub struct PassportElementErrorTranslationFiles {
pub:
	source string // Error source, must be translation_files
	@type string // Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	file_hashes []string // List of base64-encoded file hashes
	message string // Error message
}


// Represents an issue in an unspecified place. The error is considered resolved when new data is added.
pub struct PassportElementErrorUnspecified {
pub:
	source string // Error source, must be unspecified
	@type string // Type of element of the user's Telegram Passport which has the issue
	element_hash string // Base64-encoded element hash
	message string // Error message
}


// This object represents a game. Use BotFather to create and edit games, their short names will act as unique identifiers.
pub struct Game {
pub:
	title string // Title of the game
	description string // Description of the game
	photo []PhotoSize // Photo that will be displayed in the game message in chats.
	text string // Optional. Brief description of the game or high scores included in the game message. Can be automatically edited to include current high scores for the game when the bot calls setGameScore, or manually edited using editMessageText. 0-4096 characters.
	text_entities []MessageEntity // Optional. Special entities that appear in text, such as usernames, URLs, bot commands, etc.
	animation Animation // Optional. Animation that will be displayed in the game message in chats. Upload via BotFather
}


// A placeholder, currently holds no information. Use BotFather to set up your game.
pub struct CallbackGame {
pub:
	user_id int // Yes
	score int // Yes
	force bool // Optional
	disable_edit_message bool // Optional
	chat_id int // Optional
	message_id int // Optional
	inline_message_id string // Optional
}


// This object represents one row of the high scores table for a game.
pub struct GameHighScore {
pub:
	position int // Position in high score table for the game
	user User // User
	score int // Score
}

