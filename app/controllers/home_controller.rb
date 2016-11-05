class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def get_started
  end

  def authorize_bot
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
      "redirect_url" => callback_path,
      "code" => params[:code]
    }

    if params[:state] == current_user.id
      response = RestClient.post("https://slack.com/api/oauth.access", payload)
    else
      error = { error: "invald authentication" }
    end
    redirect_to root_path, error
  end
end
