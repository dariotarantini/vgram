// ResponseParameters are various errors that can be returned in APIResponse.
struct ResponseParameters {
	migrate_to_chat_id i64 // optional
	retry_after int // optional
}

// APIResponse is a response from the Telegram API with the result
// stored raw.
struct APIResponse {
	ok bool                
	result string     
	error_code int                 
	description string              
	parameters ResponseParameters 
}



// User is a user on Telegram.
struct User {
	id            int    
	first_name    string 
	last_name     string      // optional
	user_name     string       // optional
	language_code string  // optional
	is_bot        bool           // optional
}

// String displays a simple text version of a user.
//
// It is normally a user's username, but falls back to a first/last
// name as available.
// GroupChat is a group chat.
struct GroupChat {
	id int    
	title string 
}

// ChatPhoto represents a chat photo.
struct ChatPhoto {
	small_file_id string 
	big_file_id string 
}
// MessageEntity contains information about data in a Message.
struct MessageEntity {
	typ  string 
	offset int    
	length int    
	url    string   // optional
	user   *User   // optional
}

// Chat contains information about the place a message was sent.
struct Chat {
	id i64      
	typ string     
	title string // optional
	user_name string // optional
	first_name string // optional
	last_name string // optional
	all_members_are_admins bool // optional
	photo ChatPhoto 
	description string // optional
	invite_link string // optional
	pinned_message *Message // optional
}

// PhotoSize contains information about photos.
struct PhotoSize {
	file_id   string 
	width    int    
	height   int    
	file_size int     // optional
}

// Message is returned by almost every request, and contains data about
// almost anything.
struct Message {
	message_id int                
	from *User // optional
	date int                
	chat *Chat              
	forward_from *User // optional
	forward_from_chat *Chat // optional
	forward_from_message_id int // optional
	forward_date int // optional
	reply_to_message *Message // optional
	edit_date int // optional
	text string // optional
	entities []MessageEntity                   // optional
	caption_entities       []MessageEntity           // optional
	audio *Audio                                // optional
	document              *Document                          // optional
	animation             *ChatAnimation                    // optional
	game                  *Game                                  // optional
	photo                 []PhotoSize                          // optional
	sticker               *Sticker                            // optional
	video                 *Video                                // optional
	videoNote             *VideoNote                       // optional
	voice                 *Voice                                // optional
	caption               string                              // optional
	contact               *Contact                            // optional
	location              *Location                          // optional
	venue                 *Venue                                // optional
	new_chat_members        []User                    // optional
	left_chat_member        *User                      // optional
	new_chat_title          string                       // optional
	new_chat_photo          []PhotoSize                 // optional
	delete_chat_photo       bool                      // optional
	group_chat_created      bool                     // optional
	super_group_chat_created bool                // optional
	channel_chat_created    bool                   // optional
	migrate_to_chat_id     i64                    // optional
	migrate_from_chat_id     i64                  // optional
	//pinned_message         *Message                     // optional
	//invoice               *Invoice                            // optional
	//successful_payment     *SuccessfulPayment       // optional
	//passport_data          *PassportData       // optional
}


// Audio contains information about audio.
struct Audio {
	file_id    string 
	duration  int    
	performer string  // optional
	title     string      // optional
	mime_type  string  // optional
	file_size  int     // optional
}

// Document contains information about a document.
struct Document {
	file_id    string     
	thumbnail *PhotoSize      // optional
	file_name  string      // optional
	mime_type  string      // optional
	file_size  int         // optional
}

// Sticker contains information about a sticker.
struct Sticker {
	file_id    string     
	width     int        
	height    int        
	thumbnail *PhotoSize      // optional
	emoji     string          // optional
	file_size  int         // optional
	set_name   string       // optional
}

// ChatAnimation contains information about an animation.
struct ChatAnimation {
	file_id    string     
	width     int        
	height    int        
	duration  int        
	thumbnail *PhotoSize      // optional
	file_name  string      // optional
	mime_type  string      // optional
	file_size  int         // optional
}

// Video contains information about a video.
struct Video {
	file_id    string     
	width     int        
	height    int        
	duration  int        
	thumbnail *PhotoSize      // optional
	mime_type  string      // optional
	file_size  int         // optional
}

// VideoNote contains information about a video.
struct VideoNote {
	file_id   string     
	length    int        
	duration  int        
	thumbnail *PhotoSize      // optional
	file_size  int         // optional
}

// Voice contains information about a voice.
struct Voice {
	file_id   string 
	duration int    
	mime_type string  // optional
	file_size int     // optional
}

// Contact contains information about a contact.
//
// Note that LastName and UserID may be empty.
struct Contact {
	phone_number string 
	first_name   string 
	last_name    string  // optional
	user_id      int       // optional
}

// Location contains information about a place.
struct Location {
	longitude f64 
	latitude  f64 
}

// Venue contains information about a venue, including its Location.
struct Venue {
	location     Location 
	title        string   
	address      string   
	foursquare_id string    // optional
}

// UserProfilePhotos contains a set of user profile photos.
struct UserProfilePhotos {
	total_count int           
	photos     [][]PhotoSize 
}

// File contains information about a file to download from Telegram.
struct File {
	file_id   string 
	file_size int     // optional
	file_path string  // optional
}

// ReplyKeyboardMarkup allows the Bot to set a custom keyboard.
struct ReplyKeyboardMarkup {
	keyboard        [][]KeyboardButton 
	resize_keyboard  bool                  // optional
	one_time_keyboard bool                // optional
	selective       bool                        // optional
}

// KeyboardButton is a button within a custom keyboard.
struct KeyboardButton {
	text            string 
	request_contact  bool   
	request_location bool   
}

// ReplyKeyboardHide allows the Bot to hide a custom keyboard.
struct ReplyKeyboardHide {
	hide_keyboard bool 
	selective    bool  // optional
}

// ReplyKeyboardRemove allows the Bot to hide a custom keyboard.
struct ReplyKeyboardRemove {
	remove_keyboard bool 
	selective      bool 
}

// InlineKeyboardMarkup is a custom keyboard presented for an inline bot.
struct InlineKeyboardMarkup {
	inline_keyboard [][]InlineKeyboardButton 
}

// InlineKeyboardButton is a button within a custom keyboard for
// inline query responses.
//
// Note that some values are references as even an empty string
// will change behavior.
//
// CallbackGame, if set, MUST be first button in first row.
struct InlineKeyboardButton {
	text                         string        
	url                          *string                                     // optional
	callback_data                 *string                           // optional
	switch_inline_query            *string                     // optional
	switch_inline_query_current_chat *string        // optional
	callback_game                 *CallbackGame                     // optional
	pay                          bool                                        // optional
}

// CallbackQuery is data sent when a keyboard button with callback data
// is clicked.
struct CallbackQuery {
	id              string   
	from            *User    
	message         *Message            // optional
	inline_message_id string    // optional
	chat_instance    string   
	data            string               // optional
	game_short_name   string    // optional
}

// ForceReply allows the Bot to have users directly reply to it without
// additional interaction.
struct ForceReply {
	force_reply bool 
	selective  bool  // optional
}

// ChatMember is information about a member in a chat.
struct ChatMember {
	user                  *User  
	status                string 
	until_date             i64                  // optional
	can_be_edited           bool                // optional
	can_change_info         bool              // optional
	can_post_messages       bool            // optional
	can_edit_messages       bool            // optional
	can_delete_messages     bool          // optional
	can_invite_users        bool             // optional
	can_restrict_members    bool         // optional
	can_pin_messages        bool             // optional
	can_promote_members     bool          // optional
	can_send_messages       bool            // optional
	can_send_media_messages  bool      // optional
	can_send_other_messages  bool      // optional
	can_add_web_page_previews bool    // optional
}

// Game is a game within Telegram.
struct Game {
	title        string          
	description  string          
	photo        []PhotoSize     
	text         string          
	text_entities []MessageEntity 
	animation    *Animation       
}

// Animation is a GIF animation demonstrating the game.
struct Animation {
	file_id   string    
	thumb    PhotoSize 
	file_name string    
	mime_type string    
	file_size int       
}

// GameHighScore is a user's score and position on the leaderboard.
struct GameHighScore {
	position int  
	user     User 
	score    int  
}

// CallbackGame is for starting a game in an inline keyboard button.
struct CallbackGame {}

// WebhookInfo is information about a currently set webhook.
struct WebhookInfo {
	url                  string 
	has_custom_certificate bool   
	pending_update_count   int    
	last_error_date        int        // optional
	last_error_message     string  // optional
}

// InputMediaPhoto contains a photo for displaying as part of a media group.
struct InputMediaPhoto {
	typ      string 
	media     string 
	caption   string 
	parse_mode string 
}

// InputMediaVideo contains a video for displaying as part of a media group.
struct InputMediaVideo {
	typ  string 
	media string 
	// thumb intentionally missing as it is not currently compatible
	caption           string 
	parse_mode         string 
	width             int    
	height            int    
	duration          int    
	supports_streaming bool   
}

// Update is an update response, from GetUpdates.
struct Update {
	update_id           int                 
	message            *Message            
	edited_message      *Message            
	channel_post        *Message            
	edited_channel_post  *Message            
	//inline_query        *InlineQuery        
	//chosen_inline_result *ChosenInlineResult 
	callback_query      *CallbackQuery      
	//shipping_query      *ShippingQuery      
	//pre_checkout_query   *PreCheckoutQuery   
}