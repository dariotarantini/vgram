# vgram   
**vgram** is a bot library for Telegram Bot API written in V.   
The Bot API is an HTTP-based interface created for developers keen on building bots for Telegram.

It currently implement every method from Telegram Bot API 4.4.
## Installing  
```
v install vpervenditti.vgram
```
Now, edit *VPATH/vlib/builtin/option.v* and increase the option data byte, like `30000`. eg:
```v
...
struct Option {
	data    [30000]byte
	error   string
	ecode   int
	ok      bool
	is_none bool
}

// `fn foo() ?Foo { return foo }` => `fn foo() ?Foo { return opt_ok(foo); }`
fn opt_ok(data voidptr, size int) Option {
	if size >= 30000 {
		panic('option size too big: $size (max is 30000), this is a temporary limit')
	}
...
```
Now, run make again to rebuild the compiler.

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
* [`vlangbot`](examples/vlangbot.v) - run your own instance of [vlangbot](https://t.me/vlangbot)!  

## Documentation  
You can find the documentation directly on the [Telegram website](https://core.telegram.org/bots/api) or you can read it in vgram source. See methods.v and types.v.

Call a method using:
```v
method_name1(vgram.NewMethodName2{
    method_args3: xxx
})

method_name1 and method_args3 shoud be in snake_case
NewMethodName2 shoud be in PastelCase
```
Thats it. You are ready to go.