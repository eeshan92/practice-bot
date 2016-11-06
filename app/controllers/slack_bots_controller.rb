class SlackBotsController < ApplicationController
  def index
    @slack_bot = SlackBot.all.first
  end

  def authorize
    payload = {
      "client_id" => ENV["SLACK_CLIENT_ID"],
      "scope" => "channels:read chat:write:bot bot commands",
      "state" => current_user.id
    }

    redirect_to generate_url("https://slack.com/oauth/authorize", payload)
  end

  def callback
    payload = {
      "client_id" => ENV["SLACK_CLIENT_ID"],
      "client_secret" => ENV["SLACK_CLIENT_SECRET"],
      "code" => params[:code]
    }

    if params[:state] == current_user.id.to_s
      response = RestClient.post("https://slack.com/api/oauth.access", payload)
      create_slack_bot(json(response))
      notice = "Slack Bot is now installed!"
    else
      notice = "Invalid Authentication"
    end
  rescue StandardError => e
    puts e
    notice = "An error occurred, please try again"
  ensure
    redirect_to slack_bots_path, :notice => notice
  end

  private
    def create_slack_bot(data)
      @slack_bot = SlackBot.new({
        access_token: data["access_token"],
        slack_team_name: data["team_name"],
        slack_team_id: data["team_id"],
        bot_user_id: data["bot"]["bot_user_id"],
        bot_access_token: data["bot"]["bot_access_token"]
      })
      
      unless @slack_bot.save
        redirect_to slack_bots_path, :notice => "An error occurred, please try again"
      end
    end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_bot_params
      safe_params = params.permit(:access_token, :slack_team_name, :slack_team_id, :bot_user_id, :bot_access_token)
    end
end
