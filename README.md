# vgram  
**vgram** is a bot library for Telegram Bot API written in V.   
The Bot API is an HTTP-based interface created for developers keen on building bots for Telegram.
## Why don't you update the library?   
Currently I have all the code ready to release a complete version of the library, with all the methods and objects of telegrams bot API.  
However, I need two things to be added to the V language:
- fix this problem https://github.com/vlang/v/issues/1522
- get part of a json object in the rough
## Installing  
```
v install vpervenditti.vgram
```
## Creating a bot  
1. Search for the “@botfather” telegram bot and start it  
2. Click on or type /newbot to create a new bot and follow his instructions  
3. Get the token Now, create a file named mybot.v and put this code:  
```
import vpervenditti.vgram
bot := vgram.new_bot('TOKEN', false) // <- set true to see debug log
mut updates := []vgram.Update{}
mut last_offset := 0
for {
    updates = bot.get_updates(vgram.NewGetUpdates{offset: last_offset, limit: 100})
    for update in updates {
        if last_offset < update.update_id {
            last_offset = update.update_id
            match update.message.text {
                '/start' => bot.send_message(vgram.NewSendMessage{
                    chat_id: update.message.from.id.str(),
                    text: 'Hi man'
                })
            }
        }
    }
}
```
