namespace :slack_bot do
  desc "Start Freakbot"
  task :start => :environment do
    require 'slack-ruby-client'

    Slack.configure do |config|
      config.token = "xoxb-99605050691-T3LM2gC07NiX4um9CtH9kzOE"
      config.logger = Logger.new(STDOUT)
      config.logger.level = Logger::INFO
      fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end

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
      puts data

      # client.typing channel: data.channel

      case data.text
      when 'hi' then
        client.web_client.chat_postMessage(
          channel: data.channel,
          text: "hello <@#{data.user}>!",
          as_user: true,
          attachments: [{color: COLORS["fs_green"],title: "Never Enough!"}]
        )
      when 'hello' then
        client.web_client.chat_postMessage channel: data.channel, text: "Sorry <@#{data.user}>, I don't understand you", as_user: true
      end
    end

    client.start!
  end
end
