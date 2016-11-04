class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def get_started
  end

  def authorize_bot
    payload = {
      "client_id" => "19486644870.19521929059",
      "scope" => "channels:read chat:write:bot bot commands",
      "state" => current_user.id,
      "redirect_url" => callback_path
    }

    redirect_to generate_url("https://slack.com/oauth/authorize", payload)
  end

  def generate_url(url, params = {})
    uri = URI(url)
    uri.query = params.to_query
    uri.to_s
  end

  def callback
    payload = {
      "client_id" => "19486644870.19521929059",
      "client_secret" => "284f8cae95619681d4ab283d9a9d897d",
      "redirect_url" => callback_path,
      "code" => params[:code]
    }
    response = RestClient.post("https://slack.com/api/oauth.access", payload)

    puts response

    redirect_to home_path
  end
end