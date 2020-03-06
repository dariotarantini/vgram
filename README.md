# [WIP] vgram   
**vgram** is a bot library for Telegram Bot API written in V.   
The Bot API is an HTTP-based interface created for developers keen on building bots for Telegram.
## Why don't you update the library?   
Actually, there are still some problems with V language :)   

## Installing  
```
v install vpervenditti.vgram
```
## Creating a bot  
1. Search for the “@botfather” telegram bot and start it  
2. Click on or type /newbot to create a new bot and follow his instructions  
3. Get the token Now, create a file named mybot.v and put this code:  
```v
module main

import vpervenditti.vgram


fn main(){
    bot := vgram.new_bot('INSERT TOKEN HERE')
    mut updates := [vgram.Update{}]
    mut last_offset := 0
    for {
        updates = bot.get_updates(vgram.NewGetUpdates{offset: last_offset, limit: 100})
        for update in updates {
            if last_offset < update.update_id {
                last_offset = update.update_id
                if update.message.text == "/start" {
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
