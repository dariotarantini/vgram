module main

import vpervenditti.vgram


fn main(){
    bot := vgram.new_bot('TELEGRAM_BOT_TOKEN_HERE')
    mut updates := []vgram.Update{}
    mut last_offset := 0
    for {
        updates = bot.get_updates({offset: last_offset, limit: 100})
        for update in updates {
            if last_offset < update.update_id {
                last_offset = update.update_id
                if update.message.text == "/start" {
                    bot.send_chat_action({
                        chat_id: update.message.from.id.str(),
                        action: "typing"
                    })
                    bot.send_message({
                        chat_id: update.message.from.id.str(),
                        text: 'Hi man'
                    })
                }
            }
        }
    }
}