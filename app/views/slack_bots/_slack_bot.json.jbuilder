json.extract! slack_bot, :id, :access_token, :slack_team_name, :slack_team_id, :bot_user_id, :bot_access_token, :created_at, :updated_at
json.url slack_bot_url(slack_bot, format: :json)