import vgram

bot := vgram.new_bot('TOKEN')
bot_info := bot.get_me()
if bot_info.ok !== true {
    eprintln('Wrong token')
    return
}else{
    println('Auth as @$bot_info.result.username :)')
}


mut updates := resultGetUpdates{}
mut last_offset := 0
mut update = getUpdatesResp{}

for {
    updates = bot.get_updates(last_offset)

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
