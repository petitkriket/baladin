json.extract! event, :id, :address, :city, :country, :latitude, :longitude, :photo, :passenger_id, :user_id, :published, :created_at, :updated_at
json.url event_url(event, format: :json)
