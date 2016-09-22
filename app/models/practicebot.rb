require 'rubygems'
require 'telegram/bot'

token = ENV["PRACTICE_BOT_TOKEN"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
    when '/hi'
      bot.api.send_message(chat_id: message.chat.id, text: "Welcome to http://sitepoint.com")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "#{message.text}")
    end
  end
end