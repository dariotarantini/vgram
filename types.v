module vgram

/**
 * JSON types
*/


struct User {
pub:
	id            int    
	first_name    string 
	last_name     string    
	username     string
	language_code string
	is_bot        bool
}
struct ChatPhoto {
pub:
	small_file_id string 
	big_file_id string 
}
struct Chat {
pub:
	id i64      
	@type string
	title string
	username string
	first_name string
	last_name string
	all_members_are_admins bool
	photo ChatPhoto 
	description string
	invite_link string
	//pinned_message *Message
}
struct MessageEntity {
pub:
	@type string 
	offset int    
	length int    
	url string
	user User
}
struct PhotoSize {
pub:
	file_id string
	width int
	height int
	file_size int
}
struct Audio {
pub:
	file_id string 
	duration int    
	performer string
	title string
	mime_type string
	file_size int
}
struct Document {
pub:
	file_id string 
	thumb PhotoSize
	file_name string
	mime_type string
	file_size int
}
struct Video {
pub:
	file_id string 
	width int
	height int
	duration int
	thumb PhotoSize
	mime_type string
	file_size int
}
struct Animation {
pub:
	file_id string 
	width int
	height int
	duration int
	thumb PhotoSize
	mime_type string
	file_size int
}
struct MaskPosition {
pub:
	point string
	x_shift f32
	y_shift f32
	scale f32
}
struct Sticker {
pub:
	file_id string 
	width int
	height int
	is_animated bool
	thumb PhotoSize
	emoji string
	set_name string
	mask_position MaskPosition
	file_size int
}
struct VideoNote {
pub:
	file_id string 
	lenght int
	duration int
	thumb PhotoSize
	file_size int
}
struct Voice {
pub:
	file_id string 
	duration int
	mime_type string
	file_size int
}
struct Contact {
pub:
	phone_number string
	first_name string
	last_name string
	user_id int
	vcard int
}
struct Location {
pub:
	longitude f32
	latitude f32
}
struct Venue {
pub:
	location Location
	title string
	address string
	foursquare_id string
	foursquare_type string
}

struct Message {
pub:
	message_id int                
	from User
	date int                
	chat Chat              
	forward_from User
	forward_from_chat Chat 
	forward_from_message_id int
	forward_date int
	//reply_to_message *Message
	edit_date int
	text string
	entities []MessageEntity
	caption_entities []MessageEntity
	audio Audio
	document Document
	animation Animation
	//game Game <- not implemented
	photo []PhotoSize
	sticker Sticker
	video Video
	video_note VideoNote
	voice Voice
	caption string
	contact Contact
	location Location
	venue Venue
	new_chat_members []User
	left_chat_member User
	new_chat_title string
	new_chat_photo []PhotoSize
	delete_chat_photo bool
	group_chat_created bool
	super_group_chat_created bool
	channel_chat_created bool
	migrate_to_chat_id i64
	migrate_from_chat_id i64
	//pinned_message *Message
}
struct CallbackQuery {
pub:
	id string   
	from User    
	message Message            // optional
	inline_message_id string    // optional
	chat_instance string   
	data string               // optional
	game_short_name string    // optional
}
struct Update {
pub:
	update_id int                 
	message Message
	edited_message Message            
	channel_post Message            
	edited_channel_post Message            
	//inline_query InlineQuery        
	//chosen_inline_result ChosenInlineResult 
	callback_query CallbackQuery      
	//shipping_query *ShippingQuery      
	//pre_checkout_query *PreCheckoutQuery   
}
/*
ATTENCTION!
Dont use InlineKeyboard!
Its actually broken
*/
struct InlineKeyboardButton {
pub:
	text string
	url string
	//login_url LoginUrl
	callback_data string
	switch_inline_query string
	switch_inline_query_current_chat string
	//callback_game CallbackGame
	pay bool
}
struct InlineKeyboardMarkup {
pub:
	inline_keyboard [][]InlineKeyboardButton
}



/**
 * STRUCTS USED IN METHODS
*/


// getMe
struct RespGetMe {
pub:
	ok bool                
	result User
	error_code int                 
	description string              
}

// getUpdates
struct NewGetUpdates {
pub:
    offset int
    limit int
    timeout int
    allowed_updates []string
}
struct RespGetUpdates {
pub:
	ok bool                
	result []Update
	error_code int                 
	description string              
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
struct RespSendMessage {
pub:
	ok bool                
	result Message
	error_code int                 
	description string              
}

// forwardMessage
struct NewForwardMessage {
pub:
    chat_id string
	from_chat_id string
	disable_notification bool
	message_id int
}
struct RespForwardMessage {
pub:
	ok bool                
	result Message
	error_code int                 
	description string              
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
struct RespSendPhoto {
pub:
	ok bool                
	result Message
	error_code int                 
	description string              
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
struct RespSendAudio {
pub:
	ok bool                
	result Message
	error_code int                 
	description string              
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
struct RespSendDocument {
pub:
	ok bool                
	result Message
	error_code int                 
	description string              
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
struct RespSendVideo {
pub:
	ok bool                
	result Message
	error_code int                 
	description string              
}