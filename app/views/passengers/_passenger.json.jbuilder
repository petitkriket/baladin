json.extract! passenger, :id, :name, :photo, :shortcut, :token, :created_at, :updated_at
json.url passenger_url(passenger, format: :json)
