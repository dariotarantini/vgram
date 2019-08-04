# vgram  
**vgram** is a bot library for Telegram Bot API written in V.   
The Bot API is an HTTP-based interface created for developers keen on building bots for Telegram.
## Installing  
```
v install vpervenditti.vgram
```
## Creating a bot  
1. Search for the “@botfather” telegram bot and start it  
2. Click on or type /newbot to create a new bot and follow his instructions  
3. Get the token Now, create a file named mybot.v and put this code:  
```
import vgram
bot := vgram.new_bot('TOKEN', false) // <- set true to see debug log
mut updates := []vgram.Update{}
mut last_offset := 0
for {
    updates = bot.get_updates(vgram.NewGetUpdates{
        offset: last_offset
        limit: 100
    })
    for update in updates {
        if last_offset < update.update_id {
            last_offset = update.update_id
            println('>>> mid: $update.message.message_id | from: $update.message.from.first_name ($update.message.from.username) | text: $update.message.text')
            mut responsetext := 'Sorry, what do you mean?'
            if update.message.text == '/start' {
                responsetext = 'Hi man'
            }
            bot.send_message(vgram.NewSendMessage{
                chat_id: update.message.from.id.str(),
                text: responsetext
            })
            println('<<< $update.update_id | $responsetext')
        }
    }
}
```
