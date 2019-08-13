import vpervenditti.vgram

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
            if update.message.text == '/start' {
                bot.send_message(vgram.NewSendMessage{
                    chat_id: update.message.from.id.str(),
                    text: 'Hi man'
                })
            }else{
                bot.send_message(vgram.NewSendMessage{
                    chat_id: update.message.from.id.str(),
                    text: 'Sorry, what do you mean?'
                })
            }
        }
    
    }
}
