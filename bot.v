module main

import http
import json

// main struct
struct Telegram {
    Token string
}


// getMe
struct getMeResp {
mut:
    id int
    is_bot bool
    first_name string
    username string
}
struct resultGetMe {
mut:
    ok bool
    result getMeResp
}
fn (u Telegram) get_me() resultGetMe {
    url := 'https://api.telegram.org/bot{$u.Token}/getMe'
    resp := json.decode(resultGetMe, http.get(url)) or {
	    eprintln('Failed to decode json')
	    return resultGetMe{}
    }
    return resp
}


// getUpdates
struct fromMessage {
    id int
    is_bot bool
    first_name string
    last_name string
    username string
    language_code string
}
struct chatMessage {
    id int
    first_name string
    last_name string
    username string
    //type string
}
struct RespMessage {
    message_id int
    from fromMessage
    chat chatMessage
    date int
    text string
}
struct getUpdatesResp {
    update_id int
    message RespMessage
}
struct resultGetUpdates {
	ok bool
    result []getUpdatesResp
}
fn (u Telegram) get_updates(offset int) resultGetUpdates {
    url := 'https://api.telegram.org/bot{$u.Token}/getUpdates?offset='+offset.str()
    resp := json.decode(resultGetUpdates, http.get(url)) or {
	    eprintln('Failed to decode json')
	    return resultGetUpdates{}
    }
    return resp
}
// sendMessage
fn (u Telegram) send_message(chat_id int, text string)  {
    url := 'https://api.telegram.org/bot{$u.Token}/sendMessage?text=$text&chat_id='+chat_id.str()
    http.get(url)
}


fn main() {
    tg := Telegram{
        Token:'BOT_TOKEN'
    }
    println(tg.get_me().ok)
    mut updates := resultGetUpdates{}
    mut last_offset := 0
    mut update = getUpdatesResp{}
    for {
        updates = tg.get_updates(last_offset)

        for update in updates.result {
            if last_offset < update.update_id {
                last_offset = update.update_id
                println(update.message.from.id.str()+' wrote: '+update.message.text)
                if update.message.text == '/start' {
                    tg.send_message(update.message.from.id, 'Hi boy')
                }
            }
        }
    }
}	
