json.extract! location, :id, :latitude, :longitude, :address, :name, :type, :created_at, :updated_at
json.url location_url(location, format: :json)