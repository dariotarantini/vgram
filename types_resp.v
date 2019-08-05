module vgram 

struct RespUser {
pub:
	ok bool                
	result User
	error_code int                 
	description string              
}
struct RespUpdates {
pub:
	ok bool                
	result []Update
	error_code int                 
	description string              
}
struct RespMessage {
pub:
	ok bool                
	result Message
	error_code int                 
	description string              
}
