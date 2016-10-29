json.extract! attendance, :id, :practice_id, :player_id, :status, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)