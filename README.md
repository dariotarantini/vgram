# vgram   
**vgram** is a bot library for Telegram Bot API written in V.   
The Bot API is an HTTP-based interface created for developers keen on building bots for Telegram.

It currently implement every method from Telegram Bot API 4.4
## Installing  
```
v install vpervenditti.vgram
```

## Getting started  
1. Search for the “@botfather” telegram bot and start it  
2. Click on or type /newbot to create a new bot and follow his instructions  
3. Get the token Now, create a file named hi_man.v and put this code:  
```v
module main

import vpervenditti.vgram

fn main(){
    bot := vgram.new_bot('TELEGRAM_BOT_HERE')
    mut updates := [vgram.Update{}]
    mut last_offset := 0
    for {
        updates = bot.get_updates(vgram.NewGetUpdates{offset: last_offset, limit: 100})
        for update in updates {
            if last_offset < update.update_id {
                last_offset = update.update_id
                if update.message.text == "/start" {
                    bot.send_chat_action(vgram.NewSendChatAction{
                        chat_id: update.message.from.id.str(),
                        action: "typing"
                    })
                    bot.send_message(vgram.NewSendMessage{
                        chat_id: update.message.from.id.str(),
                        text: 'Hi man'
                    })
                }
            }
        }
    }
}
```
## Examples  
* [`hi_man.v`](examples/hi_man.php) - a dead simple Telegram bot in V

## Documentation  
You can find the documentation directly on the [Telegram website](https://core.telegram.org/bots/api) or you can read it in vgram source. See methods.v and types.v.

Call a method using:
```v
bot_instance.method_name({
    method_arg1: "some text"
    method_arg1: 123 // or int
})

- method_name and method_arg* shoud be in snake_case
```
Thats it. You are ready to go.