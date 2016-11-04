namespace :slack_bot do
  desc "Start Freakbot"
  task :start => :environment do
    SlackBotClient.new(ENV["SLACK_API_TOKEN"])
  end
end
