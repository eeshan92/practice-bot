class CreateSlackBots < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_bots do |t|
      t.string :access_token
      t.string :slack_team_name
      t.string :slack_team_id
      t.string :bot_user_id
      t.string :bot_access_token

      t.timestamps
    end
  end
end
