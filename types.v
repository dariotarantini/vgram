module vgram

// This object represents an incoming update.At most one of the optional parameters can be present in any given update.
pub struct Update {
pub:
	// The update's unique identifier. Update identifiers start from a certain positive number and increase sequentially. This ID becomes especially handy if you're using Webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order. If there are no new updates for at least a week, then identifier of the next update will be chosen randomly instead of sequentially.
	update_id int
	// Optional. New incoming message of any kind — text, photo, sticker, etc.
	message Message
	// Optional. New version of a message that is known to the bot and was edited
	edited_message Message
	// Optional. New incoming channel post of any kind — text, photo, sticker, etc.
	channel_post Message
	// Optional. New version of a channel post that is known to the bot and was edited
	edited_channel_post Message
	// Optional. New incoming inline query
	inline_query InlineQuery
	// Optional. The result of an inline query that was chosen by a user and sent to their chat partner. Please see our documentation on the feedback collecting for details on how to enable these updates for your bot.
	chosen_inline_result ChosenInlineResult
	// Optional. New incoming callback query
	callback_query CallbackQuery
	// Optional. New incoming shipping query. Only for invoices with flexible price
	shipping_query ShippingQuery
	// Optional. New incoming pre-checkout query. Contains full information about checkout
	pre_checkout_query PreCheckoutQuery
	// Optional. New poll state. Bots receive only updates about stopped polls and polls, which are sent by the bot
	poll Poll
	// Optional. A user changed their answer in a non-anonymous poll. Bots receive new votes only in polls that were sent by the bot itself.
	poll_answer PollAnswer
	// Optional. The bot's chat member status was updated in a chat. For private chats, this update is received only when the bot is blocked or unblocked by the user.
	my_chat_member ChatMemberUpdated
	// Optional. A chat member's status was updated in a chat. The bot must be an administrator in the chat and must explicitly specify “chat_member” in the list of allowed_updates to receive these updates.
	chat_member ChatMemberUpdated
	// Optional. A request to join the chat has been sent. The bot must have the can_invite_users administrator right in the chat to receive these updates.
	chat_join_request ChatJoinRequest
}

// Contains information about the current status of a webhook.
pub struct WebhookInfo {
pub:
	// Webhook URL, may be empty if webhook is not set up
	url string
	// True, if a custom certificate was provided for webhook certificate checks
	has_custom_certificate bool
	// Number of updates awaiting delivery
	pending_update_count int
	// Optional. Currently used webhook IP address
	ip_address string
	// Optional. Unix time for the most recent error that happened when trying to deliver an update via webhook
	last_error_date int
	// Optional. Error message in human-readable format for the most recent error that happened when trying to deliver an update via webhook
	last_error_message string
	// Optional. Maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery
	max_connections int
	// Optional. A list of update types the bot is subscribed to. Defaults to all update types except chat_member
	allowed_updates []string
}

// This object represents a Telegram user or bot.
pub struct User {
pub:
	// Unique identifier for this user or bot. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier.
	id int
	// True, if this user is a bot
	is_bot bool
	// User's or bot's first name
	first_name string
	// Optional. User's or bot's last name
	last_name string
	// Optional. User's or bot's username
	username string
	// Optional. IETF language tag of the user's language
	language_code string
	// Optional. True, if the bot can be invited to groups. Returned only in getMe.
	can_join_groups bool
	// Optional. True, if privacy mode is disabled for the bot. Returned only in getMe.
	can_read_all_group_messages bool
	// Optional. True, if the bot supports inline queries. Returned only in getMe.
	supports_inline_queries bool
}

// This object represents a chat.
pub struct Chat {
pub:
	// Unique identifier for this chat. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.
	id int
	// Type of chat, can be either “private”, “group”, “supergroup” or “channel”
	@type string
	// Optional. Title, for supergroups, channels and group chats
	title string
	// Optional. Username, for private chats, supergroups and channels if available
	username string
	// Optional. First name of the other party in a private chat
	first_name string
	// Optional. Last name of the other party in a private chat
	last_name string
	// Optional. Chat photo. Returned only in getChat.
	photo ChatPhoto
	// Optional. Bio of the other party in a private chat. Returned only in getChat.
	bio string
	// Optional. True, if privacy settings of the other party in the private chat allows to use tg://user?id=<user_id> links only in chats with the user. Returned only in getChat.
	has_private_forwards bool
	// Optional. Description, for groups, supergroups and channel chats. Returned only in getChat.
	description string
	// Optional. Primary invite link, for groups, supergroups and channel chats. Returned only in getChat.
	invite_link string
	// Optional. The most recent pinned message (by sending date). Returned only in getChat.
	// pinned_message Message
	// Optional. Default chat member permissions, for groups and supergroups. Returned only in getChat.
	permissions ChatPermissions
	// Optional. For supergroups, the minimum allowed delay between consecutive messages sent by each unpriviledged user; in seconds. Returned only in getChat.
	slow_mode_delay int
	// Optional. The time after which all messages sent to the chat will be automatically deleted; in seconds. Returned only in getChat.
	message_auto_delete_time int
	// Optional. True, if messages from the chat can't be forwarded to other chats. Returned only in getChat.
	has_protected_content bool
	// Optional. For supergroups, name of group sticker set. Returned only in getChat.
	sticker_set_name string
	// Optional. True, if the bot can change the group sticker set. Returned only in getChat.
	can_set_sticker_set bool
	// Optional. Unique identifier for the linked chat, i.e. the discussion group identifier for a channel and vice versa; for supergroups and channel chats. This identifier may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier. Returned only in getChat.
	linked_chat_id int
	// Optional. For supergroups, the location to which the supergroup is connected. Returned only in getChat.
	location ChatLocation
}

// This object represents a message.
pub struct Message {
pub:
	// Unique message identifier inside this chat
	message_id int
	// Optional. Sender of the message; empty for messages sent to channels. For backward compatibility, the field contains a fake sender user in non-channel chats, if the message was sent on behalf of a chat.
	from User
	// Optional. Sender of the message, sent on behalf of a chat. For example, the channel itself for channel posts, the supergroup itself for messages from anonymous group administrators, the linked channel for messages automatically forwarded to the discussion group. For backward compatibility, the field from contains a fake sender user in non-channel chats, if the message was sent on behalf of a chat.
	sender_chat Chat
	// Date the message was sent in Unix time
	date int
	// Conversation the message belongs to
	chat Chat
	// Optional. For forwarded messages, sender of the original message
	forward_from User
	// Optional. For messages forwarded from channels or from anonymous administrators, information about the original sender chat
	forward_from_chat Chat
	// Optional. For messages forwarded from channels, identifier of the original message in the channel
	forward_from_message_id int
	// Optional. For forwarded messages that were originally sent in channels or by an anonymous chat administrator, signature of the message sender if present
	forward_signature string
	// Optional. Sender's name for messages forwarded from users who disallow adding a link to their account in forwarded messages
	forward_sender_name string
	// Optional. For forwarded messages, date the original message was sent in Unix time
	forward_date int
	// Optional. True, if the message is a channel post that was automatically forwarded to the connected discussion group
	is_automatic_forward bool
	// Optional. For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.
	// reply_to_message &Message{}
	// Optional. Bot through which the message was sent
	via_bot User
	// Optional. Date the message was last edited in Unix time
	edit_date int
	// Optional. True, if the message can't be forwarded
	has_protected_content bool
	// Optional. The unique identifier of a media message group this message belongs to
	media_group_id string
	// Optional. Signature of the post author for messages in channels, or the custom title of an anonymous group administrator
	author_signature string
	// Optional. For text messages, the actual UTF-8 text of the message, 0-4096 characters
	text string
	// Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
	entities []MessageEntity
	// Optional. Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set
	animation Animation
	// Optional. Message is an audio file, information about the file
	audio Audio
	// Optional. Message is a general file, information about the file
	document Document
	// Optional. Message is a photo, available sizes of the photo
	photo []PhotoSize
	// Optional. Message is a sticker, information about the sticker
	sticker Sticker
	// Optional. Message is a video, information about the video
	video Video
	// Optional. Message is a video note, information about the video message
	video_note VideoNote
	// Optional. Message is a voice message, information about the file
	voice Voice
	// Optional. Caption for the animation, audio, document, photo, video or voice, 0-1024 characters
	caption string
	// Optional. For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption
	caption_entities []MessageEntity
	// Optional. Message is a shared contact, information about the contact
	contact Contact
	// Optional. Message is a dice with random value
	dice Dice
	// Optional. Message is a game, information about the game. More about games »
	game Game
	// Optional. Message is a native poll, information about the poll
	poll Poll
	// Optional. Message is a venue, information about the venue. For backward compatibility, when this field is set, the location field will also be set
	venue Venue
	// Optional. Message is a shared location, information about the location
	location Location
	// Optional. New members that were added to the group or supergroup and information about them (the bot itself may be one of these members)
	new_chat_members []User
	// Optional. A member was removed from the group, information about them (this member may be the bot itself)
	left_chat_member User
	// Optional. A chat title was changed to this value
	new_chat_title string
	// Optional. A chat photo was change to this value
	new_chat_photo []PhotoSize
	// Optional. Service message: the chat photo was deleted
	delete_chat_photo bool
	// Optional. Service message: the group has been created
	group_chat_created bool
	// Optional. Service message: the supergroup has been created. This field can't be received in a message coming through updates, because bot can't be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
	supergroup_chat_created bool
	// Optional. Service message: the channel has been created. This field can't be received in a message coming through updates, because bot can't be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
	channel_chat_created bool
	// Optional. Service message: auto-delete timer settings changed in the chat
	message_auto_delete_timer_changed MessageAutoDeleteTimerChanged
	// Optional. The group has been migrated to a supergroup with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.
	migrate_to_chat_id int
	// Optional. The supergroup has been migrated from a group with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.
	migrate_from_chat_id int
	// Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it is itself a reply.
	// pinned_message &Message{}
	// Optional. Message is an invoice for a payment, information about the invoice. More about payments »
	invoice Invoice
	// Optional. Message is a service message about a successful payment, information about the payment. More about payments »
	successful_payment SuccessfulPayment
	// Optional. The domain name of the website on which the user has logged in. More about Telegram Login »
	connected_website string
	// Optional. Telegram Passport data
	passport_data PassportData
	// Optional. Service message. A user in the chat triggered another user's proximity alert while sharing Live Location.
	proximity_alert_triggered ProximityAlertTriggered
	// Optional. Service message: voice chat scheduled
	voice_chat_scheduled VoiceChatScheduled
	// Optional. Service message: voice chat started
	voice_chat_started VoiceChatStarted
	// Optional. Service message: voice chat ended
	voice_chat_ended VoiceChatEnded
	// Optional. Service message: new participants invited to a voice chat
	voice_chat_participants_invited VoiceChatParticipantsInvited
	// Optional. Inline keyboard attached to the message. login_url buttons are represented as ordinary url buttons.
	reply_markup InlineKeyboardMarkup
}

type SMessage = Message

// This object represents a unique message identifier.
pub struct MessageId {
pub:
	// Unique message identifier
	message_id int
}

// This object represents one special entity in a text message. For example, hashtags, usernames, URLs, etc.
pub struct MessageEntity {
pub:
	// Type of the entity. Currently, can be “mention” (@username), “hashtag” (#hashtag), “cashtag” ($USD), “bot_command” (/start@jobs_bot), “url” (https://telegram.org), “email” (do-not-reply@telegram.org), “phone_number” (+1-212-555-0123), “bold” (bold text), “italic” (italic text), “underline” (underlined text), “strikethrough” (strikethrough text), “spoiler” (spoiler message), “code” (monowidth string), “pre” (monowidth block), “text_link” (for clickable text URLs), “text_mention” (for users without usernames)
	@type string
	// Offset in UTF-16 code units to the start of the entity
	offset int
	// Length of the entity in UTF-16 code units
	length int
	// Optional. For “text_link” only, url that will be opened after user taps on the text
	url string
	// Optional. For “text_mention” only, the mentioned user
	user User
	// Optional. For “pre” only, the programming language of the entity text
	language string
}

// This object represents one size of a photo or a file / sticker thumbnail.
pub struct PhotoSize {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Photo width
	width int
	// Photo height
	height int
	// Optional. File size in bytes
	file_size int
}

// This object represents an animation file (GIF or H.264/MPEG-4 AVC video without sound).
pub struct Animation {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Video width as defined by sender
	width int
	// Video height as defined by sender
	height int
	// Duration of the video in seconds as defined by sender
	duration int
	// Optional. Animation thumbnail as defined by sender
	thumb PhotoSize
	// Optional. Original animation filename as defined by sender
	file_name string
	// Optional. MIME type of the file as defined by sender
	mime_type string
	// Optional. File size in bytes
	file_size int
}

// This object represents an audio file to be treated as music by the Telegram clients.
pub struct Audio {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Duration of the audio in seconds as defined by sender
	duration int
	// Optional. Performer of the audio as defined by sender or by audio tags
	performer string
	// Optional. Title of the audio as defined by sender or by audio tags
	title string
	// Optional. Original filename as defined by sender
	file_name string
	// Optional. MIME type of the file as defined by sender
	mime_type string
	// Optional. File size in bytes
	file_size int
	// Optional. Thumbnail of the album cover to which the music file belongs
	thumb PhotoSize
}

// This object represents a general file (as opposed to photos, voice messages and audio files).
pub struct Document {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Optional. Document thumbnail as defined by sender
	thumb PhotoSize
	// Optional. Original filename as defined by sender
	file_name string
	// Optional. MIME type of the file as defined by sender
	mime_type string
	// Optional. File size in bytes
	file_size int
}

// This object represents a video file.
pub struct Video {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Video width as defined by sender
	width int
	// Video height as defined by sender
	height int
	// Duration of the video in seconds as defined by sender
	duration int
	// Optional. Video thumbnail
	thumb PhotoSize
	// Optional. Original filename as defined by sender
	file_name string
	// Optional. Mime type of a file as defined by sender
	mime_type string
	// Optional. File size in bytes
	file_size int
}

// This object represents a video message (available in Telegram apps as of v.4.0).
pub struct VideoNote {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Video width and height (diameter of the video message) as defined by sender
	length int
	// Duration of the video in seconds as defined by sender
	duration int
	// Optional. Video thumbnail
	thumb PhotoSize
	// Optional. File size in bytes
	file_size int
}

// This object represents a voice note.
pub struct Voice {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Duration of the audio in seconds as defined by sender
	duration int
	// Optional. MIME type of the file as defined by sender
	mime_type string
	// Optional. File size in bytes
	file_size int
}

// This object represents a phone contact.
pub struct Contact {
pub:
	// Contact's phone number
	phone_number string
	// Contact's first name
	first_name string
	// Optional. Contact's last name
	last_name string
	// Optional. Contact's user identifier in Telegram. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier.
	user_id int
	// Optional. Additional data about the contact in the form of a vCard
	vcard string
}

// This object represents an animated emoji that displays a random value.
pub struct Dice {
pub:
	// Emoji on which the dice throw animation is based
	emoji string
	// Value of the dice, 1-6 for “”, “” and “” base emoji, 1-5 for “” and “” base emoji, 1-64 for “” base emoji
	value int
}

// This object contains information about one answer option in a poll.
pub struct PollOption {
pub:
	// Option text, 1-100 characters
	text string
	// Number of users that voted for this option
	voter_count int
}

// This object represents an answer of a user in a non-anonymous poll.
pub struct PollAnswer {
pub:
	// Unique poll identifier
	poll_id string
	// The user, who changed the answer to the poll
	user User
	// 0-based identifiers of answer options, chosen by the user. May be empty if the user retracted their vote.
	option_ids []int
}

// This object contains information about a poll.
pub struct Poll {
pub:
	// Unique poll identifier
	id string
	// Poll question, 1-300 characters
	question string
	// List of poll options
	options []PollOption
	// Total number of users that voted in the poll
	total_voter_count int
	// True, if the poll is closed
	is_closed bool
	// True, if the poll is anonymous
	is_anonymous bool
	// Poll type, currently can be “regular” or “quiz”
	@type string
	// True, if the poll allows multiple answers
	allows_multiple_answers bool
	// Optional. 0-based identifier of the correct answer option. Available only for polls in the quiz mode, which are closed, or was sent (not forwarded) by the bot or to the private chat with the bot.
	correct_option_id int
	// Optional. Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters
	explanation string
	// Optional. Special entities like usernames, URLs, bot commands, etc. that appear in the explanation
	explanation_entities []MessageEntity
	// Optional. Amount of time in seconds the poll will be active after creation
	open_period int
	// Optional. Point in time (Unix timestamp) when the poll will be automatically closed
	close_date int
}

// This object represents a point on the map.
pub struct Location {
pub:
	// Longitude as defined by sender
	longitude f32
	// Latitude as defined by sender
	latitude f32
	// Optional. The radius of uncertainty for the location, measured in meters; 0-1500
	horizontal_accuracy f32
	// Optional. Time relative to the message sending date, during which the location can be updated; in seconds. For active live locations only.
	live_period int
	// Optional. The direction in which user is moving, in degrees; 1-360. For active live locations only.
	heading int
	// Optional. Maximum distance for proximity alerts about approaching another chat member, in meters. For sent live locations only.
	proximity_alert_radius int
}

// This object represents a venue.
pub struct Venue {
pub:
	// Venue location. Can't be a live location
	location Location
	// Name of the venue
	title string
	// Address of the venue
	address string
	// Optional. Foursquare identifier of the venue
	foursquare_id string
	// Optional. Foursquare type of the venue. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
	foursquare_type string
	// Optional. Google Places identifier of the venue
	google_place_id string
	// Optional. Google Places type of the venue. (See supported types.)
	google_place_type string
}

// This object represents the content of a service message, sent whenever a user in the chat triggers a proximity alert set by another user.
pub struct ProximityAlertTriggered {
pub:
	// User that triggered the alert
	traveler User
	// User that set the alert
	watcher User
	// The distance between the users
	distance int
}

// This object represents a service message about a change in auto-delete timer settings.
pub struct MessageAutoDeleteTimerChanged {
pub:
	// New auto-delete time for messages in the chat; in seconds
	message_auto_delete_time int
}

// This object represents a service message about a voice chat scheduled in the chat.
pub struct VoiceChatScheduled {
pub:
	// Point in time (Unix timestamp) when the voice chat is supposed to be started by a chat administrator
	start_date int
}

// This object represents a service message about a voice chat started in the chat. Currently holds no information.
pub struct VoiceChatStarted {}

// This object represents a service message about a voice chat ended in the chat.
pub struct VoiceChatEnded {
pub:
	// Voice chat duration in seconds
	duration int
}

// This object represents a service message about new members invited to a voice chat.
pub struct VoiceChatParticipantsInvited {
pub:
	// Optional. New members that were invited to the voice chat
	users []User
}

// This object represent a user's profile pictures.
pub struct UserProfilePhotos {
pub:
	// Total number of profile pictures the target user has
	total_count int
	// Requested profile pictures (in up to 4 sizes each)
	photos [][]PhotoSize
}

// This object represents a file ready to be downloaded. The file can be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile.
pub struct File {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Optional. File size in bytes, if known
	file_size int
	// Optional. File path. Use https://api.telegram.org/file/bot<token>/<file_path> to get the file.
	file_path string
}

// This object represents a custom keyboard with reply options (see Introduction to bots for details and examples).
pub struct ReplyKeyboardMarkup {
pub:
	// Array of button rows, each represented by an Array of KeyboardButton objects
	keyboard [][]KeyboardButton
	// Optional. Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
	resize_keyboard bool
	// Optional. Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat – the user can press a special button in the input field to see the custom keyboard again. Defaults to false.
	one_time_keyboard bool
	// Optional. The placeholder to be shown in the input field when the keyboard is active; 1-64 characters
	input_field_placeholder string
	// Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.Example: A user requests to change the bot's language, bot replies to the request with a keyboard to select the new language. Other users in the group don't see the keyboard.
	selective bool
}

// This object represents one button of the reply keyboard. For simple text buttons String can be used instead of this object to specify text of the button. Optional fields request_contact, request_location, and request_poll are mutually exclusive.
pub struct KeyboardButton {
pub:
	// Text of the button. If none of the optional fields are used, it will be sent as a message when the button is pressed
	text string
	// Optional. If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only
	request_contact bool
	// Optional. If True, the user's current location will be sent when the button is pressed. Available in private chats only
	request_location bool
	// Optional. If specified, the user will be asked to create a poll and send it to the bot when the button is pressed. Available in private chats only
	request_poll KeyboardButtonPollType
}

// This object represents type of a poll, which is allowed to be created and sent when the corresponding button is pressed.
pub struct KeyboardButtonPollType {
pub:
	// Optional. If quiz is passed, the user will be allowed to create only polls in the quiz mode. If regular is passed, only regular polls will be allowed. Otherwise, the user will be allowed to create a poll of any type.
	@type string
}

// Upon receiving a message with this object, Telegram clients will remove the current custom keyboard and display the default letter-keyboard. By default, custom keyboards are displayed until a new keyboard is sent by a bot. An exception is made for one-time keyboards that are hidden immediately after the user presses a button (see ReplyKeyboardMarkup).
pub struct ReplyKeyboardRemove {
pub:
	// Requests clients to remove the custom keyboard (user will not be able to summon this keyboard; if you want to hide the keyboard from sight but keep it accessible, use one_time_keyboard in ReplyKeyboardMarkup)
	remove_keyboard bool
	// Optional. Use this parameter if you want to remove the keyboard for specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.Example: A user votes in a poll, bot returns confirmation message in reply to the vote and removes the keyboard for that user, while still showing the keyboard with poll options to users who haven't voted yet.
	selective bool
}

// This object represents an inline keyboard that appears right next to the message it belongs to.
pub struct InlineKeyboardMarkup {
pub:
	// Array of button rows, each represented by an Array of InlineKeyboardButton objects
	inline_keyboard [][]InlineKeyboardButton
}

// This object represents one button of an inline keyboard. You must use exactly one of the optional fields.
pub struct InlineKeyboardButton {
pub:
	// Label text on the button
	text string
	// Optional. HTTP or tg:// url to be opened when the button is pressed. Links tg://user?id=<user_id> can be used to mention a user by their ID without using a username, if this is allowed by their privacy settings.
	url string
	// Optional. An HTTP URL used to automatically authorize the user. Can be used as a replacement for the Telegram Login Widget.
	login_url LoginUrl
	// Optional. Data to be sent in a callback query to the bot when button is pressed, 1-64 bytes
	callback_data string
	// Optional. If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot's username and the specified inline query in the input field. Can be empty, in which case just the bot's username will be inserted.Note: This offers an easy way for users to start using your bot in inline mode when they are currently in a private chat with it. Especially useful when combined with switch_pm… actions – in this case the user will be automatically returned to the chat they switched from, skipping the chat selection screen.
	switch_inline_query string
	// Optional. If set, pressing the button will insert the bot's username and the specified inline query in the current chat's input field. Can be empty, in which case only the bot's username will be inserted.This offers a quick way for the user to open your bot in inline mode in the same chat – good for selecting something from multiple options.
	switch_inline_query_current_chat string
	// Optional. Description of the game that will be launched when the user presses the button.NOTE: This type of button must always be the first button in the first row.
	callback_game CallbackGame
	// Optional. Specify True, to send a Pay button.NOTE: This type of button must always be the first button in the first row and can only be used in invoice messages.
	pay bool
}

// This object represents a parameter of the inline keyboard button used to automatically authorize a user. Serves as a great replacement for the Telegram Login Widget when the user is coming from Telegram. All the user needs to do is tap/click a button and confirm that they want to log in: Telegram apps support these buttons as of version 5.7.
pub struct LoginUrl {
pub:
	// An HTTP URL to be opened with user authorization data added to the query string when the button is pressed. If the user refuses to provide authorization data, the original URL without information about the user will be opened. The data added is the same as described in Receiving authorization data.NOTE: You must always check the hash of the received data to verify the authentication and the integrity of the data as described in Checking authorization.
	url string
	// Optional. New text of the button in forwarded messages.
	forward_text string
	// Optional. Username of a bot, which will be used for user authorization. See Setting up a bot for more details. If not specified, the current bot's username will be assumed. The url's domain must be the same as the domain linked with the bot. See Linking your domain to the bot for more details.
	bot_username string
	// Optional. Pass True to request the permission for your bot to send messages to the user.
	request_write_access bool
}

// This object represents an incoming callback query from a callback button in an inline keyboard. If the button that originated the query was attached to a message sent by the bot, the field message will be present. If the button was attached to a message sent via the bot (in inline mode), the field inline_message_id will be present. Exactly one of the fields data or game_short_name will be present.
pub struct CallbackQuery {
pub:
	// Unique identifier for this query
	id string
	// Sender
	from User
	// Optional. Message with the callback button that originated the query. Note that message content and message date will not be available if the message is too old
	message Message
	// Optional. Identifier of the message sent via the bot in inline mode, that originated the query.
	inline_message_id string
	// Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent. Useful for high scores in games.
	chat_instance string
	// Optional. Data associated with the callback button. Be aware that a bad client can send arbitrary data in this field.
	data string
	// Optional. Short name of a Game to be returned, serves as the unique identifier for the game
	game_short_name string
}

// Upon receiving a message with this object, Telegram clients will display a reply interface to the user (act as if the user has selected the bot's message and tapped 'Reply'). This can be extremely useful if you want to create user-friendly step-by-step interfaces without having to sacrifice privacy mode.
pub struct ForceReply {
pub:
	// Shows reply interface to the user, as if they manually selected the bot's message and tapped 'Reply'
	force_reply bool
	// Optional. The placeholder to be shown in the input field when the reply is active; 1-64 characters
	input_field_placeholder string
	// Optional. Use this parameter if you want to force reply from specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
	selective bool
}

// This object represents a chat photo.
pub struct ChatPhoto {
pub:
	// File identifier of small (160x160) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.
	small_file_id string
	// Unique file identifier of small (160x160) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	small_file_unique_id string
	// File identifier of big (640x640) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.
	big_file_id string
	// Unique file identifier of big (640x640) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	big_file_unique_id string
}

// Represents an invite link for a chat.
pub struct ChatInviteLink {
pub:
	// The invite link. If the link was created by another chat administrator, then the second part of the link will be replaced with “…”.
	invite_link string
	// Creator of the link
	creator User
	// True, if users joining the chat via the link need to be approved by chat administrators
	creates_join_request bool
	// True, if the link is primary
	is_primary bool
	// True, if the link is revoked
	is_revoked bool
	// Optional. Invite link name
	name string
	// Optional. Point in time (Unix timestamp) when the link will expire or has been expired
	expire_date int
	// Optional. Maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999
	member_limit int
	// Optional. Number of pending join requests created using this link
	pending_join_request_count int
}

// This object contains information about one member of a chat. Currently, the following 6 types of chat members are supported:
type ChatMember = ChatMemberAdministrator
	| ChatMemberBanned
	| ChatMemberLeft
	| ChatMemberMember
	| ChatMemberOwner
	| ChatMemberRestricted

// Represents a chat member that owns the chat and has all administrator privileges.
pub struct ChatMemberOwner {
pub:
	// The member's status in the chat, always “creator”
	status string
	// Information about the user
	user User
	// True, if the user's presence in the chat is hidden
	is_anonymous bool
	// Optional. Custom title for this user
	custom_title string
}

// Represents a chat member that has some additional privileges.
pub struct ChatMemberAdministrator {
pub:
	// The member's status in the chat, always “administrator”
	status string
	// Information about the user
	user User
	// True, if the bot is allowed to edit administrator privileges of that user
	can_be_edited bool
	// True, if the user's presence in the chat is hidden
	is_anonymous bool
	// True, if the administrator can access the chat event log, chat statistics, message statistics in channels, see channel members, see anonymous administrators in supergroups and ignore slow mode. Implied by any other administrator privilege
	can_manage_chat bool
	// True, if the administrator can delete messages of other users
	can_delete_messages bool
	// True, if the administrator can manage voice chats
	can_manage_voice_chats bool
	// True, if the administrator can restrict, ban or unban chat members
	can_restrict_members bool
	// True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that he has promoted, directly or indirectly (promoted by administrators that were appointed by the user)
	can_promote_members bool
	// True, if the user is allowed to change the chat title, photo and other settings
	can_change_info bool
	// True, if the user is allowed to invite new users to the chat
	can_invite_users bool
	// Optional. True, if the administrator can post in the channel; channels only
	can_post_messages bool
	// Optional. True, if the administrator can edit messages of other users and can pin messages; channels only
	can_edit_messages bool
	// Optional. True, if the user is allowed to pin messages; groups and supergroups only
	can_pin_messages bool
	// Optional. Custom title for this user
	custom_title string
}

// Represents a chat member that has no additional privileges or restrictions.
pub struct ChatMemberMember {
pub:
	// The member's status in the chat, always “member”
	status string
	// Information about the user
	user User
}

// Represents a chat member that is under certain restrictions in the chat. Supergroups only.
pub struct ChatMemberRestricted {
pub:
	// The member's status in the chat, always “restricted”
	status string
	// Information about the user
	user User
	// True, if the user is a member of the chat at the moment of the request
	is_member bool
	// True, if the user is allowed to change the chat title, photo and other settings
	can_change_info bool
	// True, if the user is allowed to invite new users to the chat
	can_invite_users bool
	// True, if the user is allowed to pin messages
	can_pin_messages bool
	// True, if the user is allowed to send text messages, contacts, locations and venues
	can_send_messages bool
	// True, if the user is allowed to send audios, documents, photos, videos, video notes and voice notes
	can_send_media_messages bool
	// True, if the user is allowed to send polls
	can_send_polls bool
	// True, if the user is allowed to send animations, games, stickers and use inline bots
	can_send_other_messages bool
	// True, if the user is allowed to add web page previews to their messages
	can_add_web_page_previews bool
	// Date when restrictions will be lifted for this user; unix time. If 0, then the user is restricted forever
	until_date int
}

// Represents a chat member that isn't currently a member of the chat, but may join it themselves.
pub struct ChatMemberLeft {
pub:
	// The member's status in the chat, always “left”
	status string
	// Information about the user
	user User
}

// Represents a chat member that was banned in the chat and can't return to the chat or view chat messages.
pub struct ChatMemberBanned {
pub:
	// The member's status in the chat, always “kicked”
	status string
	// Information about the user
	user User
	// Date when restrictions will be lifted for this user; unix time. If 0, then the user is banned forever
	until_date int
}

// This object represents changes in the status of a chat member.
pub struct ChatMemberUpdated {
pub:
	// Chat the user belongs to
	chat Chat
	// Performer of the action, which resulted in the change
	from User
	// Date the change was done in Unix time
	date int
	// Previous information about the chat member
	old_chat_member ChatMember
	// New information about the chat member
	new_chat_member ChatMember
	// Optional. Chat invite link, which was used by the user to join the chat; for joining by invite link events only.
	invite_link ChatInviteLink
}

// Represents a join request sent to a chat.
pub struct ChatJoinRequest {
pub:
	// Chat to which the request was sent
	chat Chat
	// User that sent the join request
	from User
	// Date the request was sent in Unix time
	date int
	// Optional. Bio of the user.
	bio string
	// Optional. Chat invite link that was used by the user to send the join request
	invite_link ChatInviteLink
}

// Describes actions that a non-administrator user is allowed to take in a chat.
pub struct ChatPermissions {
pub:
	// Optional. True, if the user is allowed to send text messages, contacts, locations and venues
	can_send_messages bool
	// Optional. True, if the user is allowed to send audios, documents, photos, videos, video notes and voice notes, implies can_send_messages
	can_send_media_messages bool
	// Optional. True, if the user is allowed to send polls, implies can_send_messages
	can_send_polls bool
	// Optional. True, if the user is allowed to send animations, games, stickers and use inline bots, implies can_send_media_messages
	can_send_other_messages bool
	// Optional. True, if the user is allowed to add web page previews to their messages, implies can_send_media_messages
	can_add_web_page_previews bool
	// Optional. True, if the user is allowed to change the chat title, photo and other settings. Ignored in public supergroups
	can_change_info bool
	// Optional. True, if the user is allowed to invite new users to the chat
	can_invite_users bool
	// Optional. True, if the user is allowed to pin messages. Ignored in public supergroups
	can_pin_messages bool
}

// Represents a location to which a chat is connected.
pub struct ChatLocation {
pub:
	// The location to which the supergroup is connected. Can't be a live location.
	location Location
	// Location address; 1-64 characters, as defined by the chat owner
	address string
}

// This object represents a bot command.
pub struct BotCommand {
pub:
	// Text of the command; 1-32 characters. Can contain only lowercase English letters, digits and underscores.
	command string
	// Description of the command; 1-256 characters.
	description string
}

// This object represents the scope to which bot commands are applied. Currently, the following 7 scopes are supported:
type BotCommandScope = BotCommandScopeAllChatAdministrators
	| BotCommandScopeAllGroupChats
	| BotCommandScopeAllPrivateChats
	| BotCommandScopeChat
	| BotCommandScopeChatAdministrators
	| BotCommandScopeChatMember
	| BotCommandScopeDefault

// Represents the default scope of bot commands. Default commands are used if no commands with a narrower scope are specified for the user.
pub struct BotCommandScopeDefault {
pub:
	// Scope type, must be default
	@type string
}

// Represents the scope of bot commands, covering all private chats.
pub struct BotCommandScopeAllPrivateChats {
pub:
	// Scope type, must be all_private_chats
	@type string
}

// Represents the scope of bot commands, covering all group and supergroup chats.
pub struct BotCommandScopeAllGroupChats {
pub:
	// Scope type, must be all_group_chats
	@type string
}

// Represents the scope of bot commands, covering all group and supergroup chat administrators.
pub struct BotCommandScopeAllChatAdministrators {
pub:
	// Scope type, must be all_chat_administrators
	@type string
}

type IntOrString = int | string

// Represents the scope of bot commands, covering a specific chat.
pub struct BotCommandScopeChat {
pub:
	// Scope type, must be chat
	@type string
	// Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	chat_id IntOrString
}

// Represents the scope of bot commands, covering all administrators of a specific group or supergroup chat.
pub struct BotCommandScopeChatAdministrators {
pub:
	// Scope type, must be chat_administrators
	@type string
	// Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	chat_id IntOrString
}

// Represents the scope of bot commands, covering a specific member of a group or supergroup chat.
pub struct BotCommandScopeChatMember {
pub:
	// Scope type, must be chat_member
	@type string
	// Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
	chat_id IntOrString
	// Unique identifier of the target user
	user_id int
}

// Contains information about why a request was unsuccessful.
pub struct ResponseParameters {
pub:
	// Optional. The group has been migrated to a supergroup with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.
	migrate_to_chat_id int
	// Optional. In case of exceeding flood control, the number of seconds left to wait before the request can be repeated
	retry_after int
}

// This object represents the content of a media message to be sent. It should be one of
type InputMedia = InputMediaAnimation
	| InputMediaAudio
	| InputMediaDocument
	| InputMediaPhoto
	| InputMediaVideo

// Represents a photo to be sent.
pub struct InputMediaPhoto {
pub:
	// Type of the result, must be photo
	@type string
	// File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	media string
	// Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the photo caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
}

// Represents a video to be sent.
pub struct InputMediaVideo {
pub:
	// Type of the result, must be video
	@type string
	// File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	media string
	// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	thumb string
	// Optional. Caption of the video to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the video caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Video width
	width int
	// Optional. Video height
	height int
	// Optional. Video duration in seconds
	duration int
	// Optional. Pass True, if the uploaded video is suitable for streaming
	supports_streaming bool
}

// Represents an animation file (GIF or H.264/MPEG-4 AVC video without sound) to be sent.
pub struct InputMediaAnimation {
pub:
	// Type of the result, must be animation
	@type string
	// File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	media string
	// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	thumb string
	// Optional. Caption of the animation to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the animation caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Animation width
	width int
	// Optional. Animation height
	height int
	// Optional. Animation duration in seconds
	duration int
}

// Represents an audio file to be treated as music to be sent.
pub struct InputMediaAudio {
pub:
	// Type of the result, must be audio
	@type string
	// File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	media string
	// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	thumb string
	// Optional. Caption of the audio to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the audio caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Duration of the audio in seconds
	duration int
	// Optional. Performer of the audio
	performer string
	// Optional. Title of the audio
	title string
}

// Represents a general file to be sent.
pub struct InputMediaDocument {
pub:
	// Type of the result, must be document
	@type string
	// File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More info on Sending Files »
	media string
	// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More info on Sending Files »
	thumb string
	// Optional. Caption of the document to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the document caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Disables automatic server-side content type detection for files uploaded using multipart/form-data. Always True, if the document is sent as part of an album.
	disable_content_type_detection bool
}

// This object represents the contents of a file to be uploaded. Must be posted using multipart/form-data in the usual way that files are uploaded via the browser.
pub struct InputFile {}

// This object represents a sticker.
pub struct Sticker {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// Sticker width
	width int
	// Sticker height
	height int
	// True, if the sticker is animated
	is_animated bool
	// Optional. Sticker thumbnail in the .WEBP or .JPG format
	thumb PhotoSize
	// Optional. Emoji associated with the sticker
	emoji string
	// Optional. Name of the sticker set to which the sticker belongs
	set_name string
	// Optional. For mask stickers, the position where the mask should be placed
	mask_position MaskPosition
	// Optional. File size in bytes
	file_size int
}

// This object represents a sticker set.
pub struct StickerSet {
pub:
	// Sticker set name
	name string
	// Sticker set title
	title string
	// True, if the sticker set contains animated stickers
	is_animated bool
	// True, if the sticker set contains masks
	contains_masks bool
	// List of all set stickers
	stickers []Sticker
	// Optional. Sticker set thumbnail in the .WEBP or .TGS format
	thumb PhotoSize
}

// This object describes the position on faces where a mask should be placed by default.
pub struct MaskPosition {
pub:
	// The part of the face relative to which the mask should be placed. One of “forehead”, “eyes”, “mouth”, or “chin”.
	point string
	// Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position.
	x_shift f32
	// Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position.
	y_shift f32
	// Mask scaling coefficient. For example, 2.0 means double size.
	scale f32
}

// This object represents an incoming inline query. When the user sends an empty query, your bot could return some default or trending results.
pub struct InlineQuery {
pub:
	// Unique identifier for this query
	id string
	// Sender
	from User
	// Text of the query (up to 256 characters)
	query string
	// Offset of the results to be returned, can be controlled by the bot
	offset string
	// Optional. Type of the chat, from which the inline query was sent. Can be either “sender” for a private chat with the inline query sender, “private”, “group”, “supergroup”, or “channel”. The chat type should be always known for requests sent from official clients and most third-party clients, unless the request was sent from a secret chat
	chat_type string
	// Optional. Sender location, only for bots that request user location
	location Location
}

// This object represents one result of an inline query. Telegram clients currently support results of the following 20 types:
type InlineQueryResult = InlineQueryResultArticle
	| InlineQueryResultAudio
	| InlineQueryResultCachedAudio
	| InlineQueryResultCachedDocument
	| InlineQueryResultCachedGif
	| InlineQueryResultCachedPhoto
	| InlineQueryResultCachedSticker
	| InlineQueryResultCachedVideo
	| InlineQueryResultCachedVoice
	| InlineQueryResultContact
	| InlineQueryResultDocument
	| InlineQueryResultGame
	| InlineQueryResultGif
	| InlineQueryResultLocation
	| InlineQueryResultMpeg4Gif
	| InlineQueryResultPhoto
	| InlineQueryResultVenue
	| InlineQueryResultVideo
	| InlineQueryResultVoice

// Represents a link to an article or web page.
pub struct InlineQueryResultArticle {
pub:
	// Type of the result, must be article
	@type string
	// Unique identifier for this result, 1-64 Bytes
	id string
	// Title of the result
	title string
	// Content of the message to be sent
	input_message_content InputMessageContent
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. URL of the result
	url string
	// Optional. Pass True, if you don't want the URL to be shown in the message
	hide_url bool
	// Optional. Short description of the result
	description string
	// Optional. Url of the thumbnail for the result
	thumb_url string
	// Optional. Thumbnail width
	thumb_width int
	// Optional. Thumbnail height
	thumb_height int
}

// Represents a link to a photo. By default, this photo will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.
pub struct InlineQueryResultPhoto {
pub:
	// Type of the result, must be photo
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid URL of the photo. Photo must be in JPEG format. Photo size must not exceed 5MB
	photo_url string
	// URL of the thumbnail for the photo
	thumb_url string
	// Optional. Width of the photo
	photo_width int
	// Optional. Height of the photo
	photo_height int
	// Optional. Title for the result
	title string
	// Optional. Short description of the result
	description string
	// Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the photo caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the photo
	input_message_content InputMessageContent
}

// Represents a link to an animated GIF file. By default, this animated GIF file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.
pub struct InlineQueryResultGif {
pub:
	// Type of the result, must be gif
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid URL for the GIF file. File size must not exceed 1MB
	gif_url string
	// Optional. Width of the GIF
	gif_width int
	// Optional. Height of the GIF
	gif_height int
	// Optional. Duration of the GIF in seconds
	gif_duration int
	// URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result
	thumb_url string
	// Optional. MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”
	thumb_mime_type string
	// Optional. Title for the result
	title string
	// Optional. Caption of the GIF file to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the GIF animation
	input_message_content InputMessageContent
}

// Represents a link to a video animation (H.264/MPEG-4 AVC video without sound). By default, this animated MPEG-4 file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.
pub struct InlineQueryResultMpeg4Gif {
pub:
	// Type of the result, must be mpeg4_gif
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid URL for the MP4 file. File size must not exceed 1MB
	mpeg4_url string
	// Optional. Video width
	mpeg4_width int
	// Optional. Video height
	mpeg4_height int
	// Optional. Video duration in seconds
	mpeg4_duration int
	// URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result
	thumb_url string
	// Optional. MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”
	thumb_mime_type string
	// Optional. Title for the result
	title string
	// Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the video animation
	input_message_content InputMessageContent
}

// Represents a link to a page containing an embedded video player or a video file. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.
pub struct InlineQueryResultVideo {
pub:
	// Type of the result, must be video
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid URL for the embedded video player or video file
	video_url string
	// Mime type of the content of video url, “text/html” or “video/mp4”
	mime_type string
	// URL of the thumbnail (JPEG only) for the video
	thumb_url string
	// Title for the result
	title string
	// Optional. Caption of the video to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the video caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Video width
	video_width int
	// Optional. Video height
	video_height int
	// Optional. Video duration in seconds
	video_duration int
	// Optional. Short description of the result
	description string
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the video. This field is required if InlineQueryResultVideo is used to send an HTML-page as a result (e.g., a YouTube video).
	input_message_content InputMessageContent
}

// Represents a link to an MP3 audio file. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.
pub struct InlineQueryResultAudio {
pub:
	// Type of the result, must be audio
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid URL for the audio file
	audio_url string
	// Title
	title string
	// Optional. Caption, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the audio caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Performer
	performer string
	// Optional. Audio duration in seconds
	audio_duration int
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the audio
	input_message_content InputMessageContent
}

// Represents a link to a voice recording in an .OGG container encoded with OPUS. By default, this voice recording will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the the voice message.
pub struct InlineQueryResultVoice {
pub:
	// Type of the result, must be voice
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid URL for the voice recording
	voice_url string
	// Recording title
	title string
	// Optional. Caption, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the voice message caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Recording duration in seconds
	voice_duration int
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the voice recording
	input_message_content InputMessageContent
}

// Represents a link to a file. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file. Currently, only .PDF and .ZIP files can be sent using this method.
pub struct InlineQueryResultDocument {
pub:
	// Type of the result, must be document
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// Title for the result
	title string
	// Optional. Caption of the document to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the document caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// A valid URL for the file
	document_url string
	// Mime type of the content of the file, either “application/pdf” or “application/zip”
	mime_type string
	// Optional. Short description of the result
	description string
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the file
	input_message_content InputMessageContent
	// Optional. URL of the thumbnail (JPEG only) for the file
	thumb_url string
	// Optional. Thumbnail width
	thumb_width int
	// Optional. Thumbnail height
	thumb_height int
}

// Represents a location on a map. By default, the location will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the location.
pub struct InlineQueryResultLocation {
pub:
	// Type of the result, must be location
	@type string
	// Unique identifier for this result, 1-64 Bytes
	id string
	// Location latitude in degrees
	latitude f32
	// Location longitude in degrees
	longitude f32
	// Location title
	title string
	// Optional. The radius of uncertainty for the location, measured in meters; 0-1500
	horizontal_accuracy f32
	// Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.
	live_period int
	// Optional. For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.
	heading int
	// Optional. For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.
	proximity_alert_radius int
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the location
	input_message_content InputMessageContent
	// Optional. Url of the thumbnail for the result
	thumb_url string
	// Optional. Thumbnail width
	thumb_width int
	// Optional. Thumbnail height
	thumb_height int
}

// Represents a venue. By default, the venue will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the venue.
pub struct InlineQueryResultVenue {
pub:
	// Type of the result, must be venue
	@type string
	// Unique identifier for this result, 1-64 Bytes
	id string
	// Latitude of the venue location in degrees
	latitude f32
	// Longitude of the venue location in degrees
	longitude f32
	// Title of the venue
	title string
	// Address of the venue
	address string
	// Optional. Foursquare identifier of the venue if known
	foursquare_id string
	// Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
	foursquare_type string
	// Optional. Google Places identifier of the venue
	google_place_id string
	// Optional. Google Places type of the venue. (See supported types.)
	google_place_type string
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the venue
	input_message_content InputMessageContent
	// Optional. Url of the thumbnail for the result
	thumb_url string
	// Optional. Thumbnail width
	thumb_width int
	// Optional. Thumbnail height
	thumb_height int
}

// Represents a contact with a phone number. By default, this contact will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the contact.
pub struct InlineQueryResultContact {
pub:
	// Type of the result, must be contact
	@type string
	// Unique identifier for this result, 1-64 Bytes
	id string
	// Contact's phone number
	phone_number string
	// Contact's first name
	first_name string
	// Optional. Contact's last name
	last_name string
	// Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes
	vcard string
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the contact
	input_message_content InputMessageContent
	// Optional. Url of the thumbnail for the result
	thumb_url string
	// Optional. Thumbnail width
	thumb_width int
	// Optional. Thumbnail height
	thumb_height int
}

// Represents a Game.
pub struct InlineQueryResultGame {
pub:
	// Type of the result, must be game
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// Short name of the game
	game_short_name string
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
}

// Represents a link to a photo stored on the Telegram servers. By default, this photo will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.
pub struct InlineQueryResultCachedPhoto {
pub:
	// Type of the result, must be photo
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid file identifier of the photo
	photo_file_id string
	// Optional. Title for the result
	title string
	// Optional. Short description of the result
	description string
	// Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the photo caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the photo
	input_message_content InputMessageContent
}

// Represents a link to an animated GIF file stored on the Telegram servers. By default, this animated GIF file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with specified content instead of the animation.
pub struct InlineQueryResultCachedGif {
pub:
	// Type of the result, must be gif
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid file identifier for the GIF file
	gif_file_id string
	// Optional. Title for the result
	title string
	// Optional. Caption of the GIF file to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the GIF animation
	input_message_content InputMessageContent
}

// Represents a link to a video animation (H.264/MPEG-4 AVC video without sound) stored on the Telegram servers. By default, this animated MPEG-4 file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.
pub struct InlineQueryResultCachedMpeg4Gif {
pub:
	// Type of the result, must be mpeg4_gif
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid file identifier for the MP4 file
	mpeg4_file_id string
	// Optional. Title for the result
	title string
	// Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the video animation
	input_message_content InputMessageContent
}

// Represents a link to a sticker stored on the Telegram servers. By default, this sticker will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the sticker.
pub struct InlineQueryResultCachedSticker {
pub:
	// Type of the result, must be sticker
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid file identifier of the sticker
	sticker_file_id string
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the sticker
	input_message_content InputMessageContent
}

// Represents a link to a file stored on the Telegram servers. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file.
pub struct InlineQueryResultCachedDocument {
pub:
	// Type of the result, must be document
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// Title for the result
	title string
	// A valid file identifier for the file
	document_file_id string
	// Optional. Short description of the result
	description string
	// Optional. Caption of the document to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the document caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the file
	input_message_content InputMessageContent
}

// Represents a link to a video file stored on the Telegram servers. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.
pub struct InlineQueryResultCachedVideo {
pub:
	// Type of the result, must be video
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid file identifier for the video file
	video_file_id string
	// Title for the result
	title string
	// Optional. Short description of the result
	description string
	// Optional. Caption of the video to be sent, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the video caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the video
	input_message_content InputMessageContent
}

// Represents a link to a voice message stored on the Telegram servers. By default, this voice message will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the voice message.
pub struct InlineQueryResultCachedVoice {
pub:
	// Type of the result, must be voice
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid file identifier for the voice message
	voice_file_id string
	// Voice message title
	title string
	// Optional. Caption, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the voice message caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the voice message
	input_message_content InputMessageContent
}

// Represents a link to an MP3 audio file stored on the Telegram servers. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.
pub struct InlineQueryResultCachedAudio {
pub:
	// Type of the result, must be audio
	@type string
	// Unique identifier for this result, 1-64 bytes
	id string
	// A valid file identifier for the audio file
	audio_file_id string
	// Optional. Caption, 0-1024 characters after entities parsing
	caption string
	// Optional. Mode for parsing entities in the audio caption. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode
	caption_entities []MessageEntity
	// Optional. Inline keyboard attached to the message
	reply_markup InlineKeyboardMarkup
	// Optional. Content of the message to be sent instead of the audio
	input_message_content InputMessageContent
}

// This object represents the content of a message to be sent as a result of an inline query. Telegram clients currently support the following 5 types:
type InputMessageContent = InputContactMessageContent
	| InputInvoiceMessageContent
	| InputLocationMessageContent
	| InputTextMessageContent
	| InputVenueMessageContent

// Represents the content of a text message to be sent as the result of an inline query.
pub struct InputTextMessageContent {
pub:
	// Text of the message to be sent, 1-4096 characters
	message_text string
	// Optional. Mode for parsing entities in the message text. See formatting options for more details.
	parse_mode string
	// Optional. List of special entities that appear in message text, which can be specified instead of parse_mode
	entities []MessageEntity
	// Optional. Disables link previews for links in the sent message
	disable_web_page_preview bool
}

// Represents the content of a location message to be sent as the result of an inline query.
pub struct InputLocationMessageContent {
pub:
	// Latitude of the location in degrees
	latitude f32
	// Longitude of the location in degrees
	longitude f32
	// Optional. The radius of uncertainty for the location, measured in meters; 0-1500
	horizontal_accuracy f32
	// Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.
	live_period int
	// Optional. For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.
	heading int
	// Optional. For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.
	proximity_alert_radius int
}

// Represents the content of a venue message to be sent as the result of an inline query.
pub struct InputVenueMessageContent {
pub:
	// Latitude of the venue in degrees
	latitude f32
	// Longitude of the venue in degrees
	longitude f32
	// Name of the venue
	title string
	// Address of the venue
	address string
	// Optional. Foursquare identifier of the venue, if known
	foursquare_id string
	// Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
	foursquare_type string
	// Optional. Google Places identifier of the venue
	google_place_id string
	// Optional. Google Places type of the venue. (See supported types.)
	google_place_type string
}

// Represents the content of a contact message to be sent as the result of an inline query.
pub struct InputContactMessageContent {
pub:
	// Contact's phone number
	phone_number string
	// Contact's first name
	first_name string
	// Optional. Contact's last name
	last_name string
	// Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes
	vcard string
}

// Represents the content of an invoice message to be sent as the result of an inline query.
pub struct InputInvoiceMessageContent {
pub:
	// Product name, 1-32 characters
	title string
	// Product description, 1-255 characters
	description string
	// Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use for your internal processes.
	payload string
	// Payment provider token, obtained via Botfather
	provider_token string
	// Three-letter ISO 4217 currency code, see more on currencies
	currency string
	// Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.)
	prices []LabeledPrice
	// Optional. The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of US$ 1.45 pass max_tip_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0
	max_tip_amount int
	// Optional. A JSON-serialized array of suggested amounts of tip in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.
	suggested_tip_amounts []int
	// Optional. A JSON-serialized object for data about the invoice, which will be shared with the payment provider. A detailed description of the required fields should be provided by the payment provider.
	provider_data string
	// Optional. URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service. People like it better when they see what they are paying for.
	photo_url string
	// Optional. Photo size
	photo_size int
	// Optional. Photo width
	photo_width int
	// Optional. Photo height
	photo_height int
	// Optional. Pass True, if you require the user's full name to complete the order
	need_name bool
	// Optional. Pass True, if you require the user's phone number to complete the order
	need_phone_number bool
	// Optional. Pass True, if you require the user's email address to complete the order
	need_email bool
	// Optional. Pass True, if you require the user's shipping address to complete the order
	need_shipping_address bool
	// Optional. Pass True, if user's phone number should be sent to provider
	send_phone_number_to_provider bool
	// Optional. Pass True, if user's email address should be sent to provider
	send_email_to_provider bool
	// Optional. Pass True, if the final price depends on the shipping method
	is_flexible bool
}

// Represents a result of an inline query that was chosen by the user and sent to their chat partner.
pub struct ChosenInlineResult {
pub:
	// The unique identifier for the result that was chosen
	result_id string
	// The user that chose the result
	from User
	// Optional. Sender location, only for bots that require user location
	location Location
	// Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message. Will be also received in callback queries and can be used to edit the message.
	inline_message_id string
	// The query that was used to obtain the result
	query string
}

// This object represents a portion of the price for goods or services.
pub struct LabeledPrice {
pub:
	// Portion label
	label string
	// Price of the product in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
	amount int
}

// This object contains basic information about an invoice.
pub struct Invoice {
pub:
	// Product name
	title string
	// Product description
	description string
	// Unique bot deep-linking parameter that can be used to generate this invoice
	start_parameter string
	// Three-letter ISO 4217 currency code
	currency string
	// Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
	total_amount int
}

// This object represents a shipping address.
pub struct ShippingAddress {
pub:
	// ISO 3166-1 alpha-2 country code
	country_code string
	// State, if applicable
	state string
	// City
	city string
	// First line for the address
	street_line1 string
	// Second line for the address
	street_line2 string
	// Address post code
	post_code string
}

// This object represents information about an order.
pub struct OrderInfo {
pub:
	// Optional. User name
	name string
	// Optional. User's phone number
	phone_number string
	// Optional. User email
	email string
	// Optional. User shipping address
	shipping_address ShippingAddress
}

// This object represents one shipping option.
pub struct ShippingOption {
pub:
	// Shipping option identifier
	id string
	// Option title
	title string
	// List of price portions
	prices []LabeledPrice
}

// This object contains basic information about a successful payment.
pub struct SuccessfulPayment {
pub:
	// Three-letter ISO 4217 currency code
	currency string
	// Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
	total_amount int
	// Bot specified invoice payload
	invoice_payload string
	// Optional. Identifier of the shipping option chosen by the user
	shipping_option_id string
	// Optional. Order info provided by the user
	order_info OrderInfo
	// Telegram payment identifier
	telegram_payment_charge_id string
	// Provider payment identifier
	provider_payment_charge_id string
}

// This object contains information about an incoming shipping query.
pub struct ShippingQuery {
pub:
	// Unique query identifier
	id string
	// User who sent the query
	from User
	// Bot specified invoice payload
	invoice_payload string
	// User specified shipping address
	shipping_address ShippingAddress
}

// This object contains information about an incoming pre-checkout query.
pub struct PreCheckoutQuery {
pub:
	// Unique query identifier
	id string
	// User who sent the query
	from User
	// Three-letter ISO 4217 currency code
	currency string
	// Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
	total_amount int
	// Bot specified invoice payload
	invoice_payload string
	// Optional. Identifier of the shipping option chosen by the user
	shipping_option_id string
	// Optional. Order info provided by the user
	order_info OrderInfo
}

// Contains information about Telegram Passport data shared with the bot by the user.
pub struct PassportData {
pub:
	// Array with information about documents and other Telegram Passport elements that was shared with the bot
	data []EncryptedPassportElement
	// Encrypted credentials required to decrypt the data
	credentials EncryptedCredentials
}

// This object represents a file uploaded to Telegram Passport. Currently all Telegram Passport files are in JPEG format when decrypted and don't exceed 10MB.
pub struct PassportFile {
pub:
	// Identifier for this file, which can be used to download or reuse the file
	file_id string
	// Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.
	file_unique_id string
	// File size in bytes
	file_size int
	// Unix time when the file was uploaded
	file_date int
}

// Contains information about documents or other Telegram Passport elements shared with the bot by the user.
pub struct EncryptedPassportElement {
pub:
	// Element type. One of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”, “phone_number”, “email”.
	@type string
	// Optional. Base64-encoded encrypted Telegram Passport element data provided by the user, available for “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport” and “address” types. Can be decrypted and verified using the accompanying EncryptedCredentials.
	data string
	// Optional. User's verified phone number, available only for “phone_number” type
	phone_number string
	// Optional. User's verified email address, available only for “email” type
	email string
	// Optional. Array of encrypted files with documents provided by the user, available for “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.
	files []PassportFile
	// Optional. Encrypted file with the front side of the document, provided by the user. Available for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.
	front_side PassportFile
	// Optional. Encrypted file with the reverse side of the document, provided by the user. Available for “driver_license” and “identity_card”. The file can be decrypted and verified using the accompanying EncryptedCredentials.
	reverse_side PassportFile
	// Optional. Encrypted file with the selfie of the user holding a document, provided by the user; available for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.
	selfie PassportFile
	// Optional. Array of encrypted files with translated versions of documents provided by the user. Available if requested for “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.
	translation []PassportFile
	// Base64-encoded element hash for using in PassportElementErrorUnspecified
	hash string
}

// Contains data required for decrypting and authenticating EncryptedPassportElement. See the Telegram Passport Documentation for a complete description of the data decryption and authentication processes.
pub struct EncryptedCredentials {
pub:
	// Base64-encoded encrypted JSON-serialized data with unique user's payload, data hashes and secrets required for EncryptedPassportElement decryption and authentication
	data string
	// Base64-encoded data hash for data authentication
	hash string
	// Base64-encoded secret, encrypted with the bot's public RSA key, required for data decryption
	secret string
}

// This object represents an error in the Telegram Passport element which was submitted that should be resolved by the user. It should be one of:
type PassportElementError = PassportElementErrorDataField
	| PassportElementErrorFile
	| PassportElementErrorFiles
	| PassportElementErrorFrontSide
	| PassportElementErrorReverseSide
	| PassportElementErrorSelfie
	| PassportElementErrorTranslationFile
	| PassportElementErrorTranslationFiles
	| PassportElementErrorUnspecified

// Represents an issue in one of the data fields that was provided by the user. The error is considered resolved when the field's value changes.
pub struct PassportElementErrorDataField {
pub:
	// Error source, must be data
	source string
	// The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”
	@type string
	// Name of the data field which has the error
	field_name string
	// Base64-encoded data hash
	data_hash string
	// Error message
	message string
}

// Represents an issue with the front side of a document. The error is considered resolved when the file with the front side of the document changes.
pub struct PassportElementErrorFrontSide {
pub:
	// Error source, must be front_side
	source string
	// The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”
	@type string
	// Base64-encoded hash of the file with the front side of the document
	file_hash string
	// Error message
	message string
}

// Represents an issue with the reverse side of a document. The error is considered resolved when the file with reverse side of the document changes.
pub struct PassportElementErrorReverseSide {
pub:
	// Error source, must be reverse_side
	source string
	// The section of the user's Telegram Passport which has the issue, one of “driver_license”, “identity_card”
	@type string
	// Base64-encoded hash of the file with the reverse side of the document
	file_hash string
	// Error message
	message string
}

// Represents an issue with the selfie with a document. The error is considered resolved when the file with the selfie changes.
pub struct PassportElementErrorSelfie {
pub:
	// Error source, must be selfie
	source string
	// The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”
	@type string
	// Base64-encoded hash of the file with the selfie
	file_hash string
	// Error message
	message string
}

// Represents an issue with a document scan. The error is considered resolved when the file with the document scan changes.
pub struct PassportElementErrorFile {
pub:
	// Error source, must be file
	source string
	// The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	@type string
	// Base64-encoded file hash
	file_hash string
	// Error message
	message string
}

// Represents an issue with a list of scans. The error is considered resolved when the list of files containing the scans changes.
pub struct PassportElementErrorFiles {
pub:
	// Error source, must be files
	source string
	// The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	@type string
	// List of base64-encoded file hashes
	file_hashes []string
	// Error message
	message string
}

// Represents an issue with one of the files that constitute the translation of a document. The error is considered resolved when the file changes.
pub struct PassportElementErrorTranslationFile {
pub:
	// Error source, must be translation_file
	source string
	// Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	@type string
	// Base64-encoded file hash
	file_hash string
	// Error message
	message string
}

// Represents an issue with the translated version of a document. The error is considered resolved when a file with the document translation change.
pub struct PassportElementErrorTranslationFiles {
pub:
	// Error source, must be translation_files
	source string
	// Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”
	@type string
	// List of base64-encoded file hashes
	file_hashes []string
	// Error message
	message string
}

// Represents an issue in an unspecified place. The error is considered resolved when new data is added.
pub struct PassportElementErrorUnspecified {
pub:
	// Error source, must be unspecified
	source string
	// Type of element of the user's Telegram Passport which has the issue
	@type string
	// Base64-encoded element hash
	element_hash string
	// Error message
	message string
}

// This object represents a game. Use BotFather to create and edit games, their short names will act as unique identifiers.
pub struct Game {
pub:
	// Title of the game
	title string
	// Description of the game
	description string
	// Photo that will be displayed in the game message in chats.
	photo []PhotoSize
	// Optional. Brief description of the game or high scores included in the game message. Can be automatically edited to include current high scores for the game when the bot calls setGameScore, or manually edited using editMessageText. 0-4096 characters.
	text string
	// Optional. Special entities that appear in text, such as usernames, URLs, bot commands, etc.
	text_entities []MessageEntity
	// Optional. Animation that will be displayed in the game message in chats. Upload via BotFather
	animation Animation
}

// A placeholder, currently holds no information. Use BotFather to set up your game.
pub struct CallbackGame {}

// This object represents one row of the high scores table for a game.
pub struct GameHighScore {
pub:
	// Position in high score table for the game
	position int
	// User
	user User
	// Score
	score int
}
