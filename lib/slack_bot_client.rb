require 'slack-ruby-client'

class SlackBotClient

  def initialize(token)
    Slack.configure do |config|
      config.token = token
      config.logger = Logger.new(STDOUT)
      config.logger.level = Logger::INFO
      fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end
    start_client
  end

  def start_client
    client = Slack::RealTime::Client.new

    client.on :hello do
      puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
    end

    client.on :close do |_data|
      puts 'Connection closing, exiting.'
    end

    client.on :closed do |_data|
      puts 'Connection has been disconnected.'
    end

    client.on :message do |data|
      puts "Incoming message\n#{data}"

      handle_message(data, client)
    end

    client.start!
  end

  def handle_message(data, client)
    case data.text
    when 'hi' then
      client.web_client.chat_postMessage(
        {
          channel: data.channel,
          text: "hello <@#{data.user}>!",
          as_user: true,
          attachments: [
            {
              color: COLORS["fs_green"],
              title: "Never Enough!"
            }
          ]
        })
    when /list/ then
      practices = Practice.public_send(:after, Date.today).order("date asc").take(2)
      client.web_client.chat_postMessage(
        {
          channel: data.channel,
          text: "hello <@#{data.user}>!",
          as_user: true,
          attachments: practices.map do |practice|
            {
              color: COLORS["fs_green"],
              title: practice.date
            }
          end
        })
    when 'hello' then
      client.web_client.chat_postMessage(
        {
          channel: data.channel,
          text: "Sorry <@#{data.user}>, I don't understand you",
          as_user: true
        })
    end
  end
end
