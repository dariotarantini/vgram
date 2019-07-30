module vgram


// method's types
struct APIResponse {
pub:
	ok bool                
	result string
	error_code int                 
	description string              
}

struct NewGetUpdates {
pub:
    offset int
    limit int
    timeout int
    allowed_updates []string
mut:
    method string
}
struct NewGetMe {
mut:
    method string
}
struct NewSendMessage {
pub:
    chat_id string
    text string
    parse_mode string
    disable_web_page_preview bool
    disable_notification bool
    reply_to_message_id int
    reply_markup string
mut: 
    method string
}

// json object
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
	typ string
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
	typ string 
	offset int    
	length int    
	url string
	user User
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
	//document              *Document                          // optional
	//animation             *ChatAnimation                    // optional
	//game                  *Game                                  // optional
	//photo                 []PhotoSize                          // optional
	//sticker               *Sticker                            // optional
	//video                 *Video                                // optional
	//videoNote             *VideoNote                       // optional
	//voice                 *Voice                                // optional
	caption               string                              // optional
	//contact               *Contact                            // optional
	//location              *Location                          // optional
	//venue                 *Venue                                // optional
	new_chat_members        []User                    // optional
	left_chat_member        User                      // optional
	new_chat_title          string                       // optional
	//new_chat_photo          []PhotoSize                 // optional
	delete_chat_photo       bool                      // optional
	group_chat_created      bool                     // optional
	super_group_chat_created bool                // optional
	channel_chat_created    bool                   // optional
	migrate_to_chat_id     i64                    // optional
	migrate_from_chat_id     i64                  // optional
	//pinned_message         *Message
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
