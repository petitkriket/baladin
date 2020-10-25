Geocoder.configure(
  timeout: 8000,             # geocoding service timeout (secs)
  lookup: :google,           # name of geocoding service (symbol)
  use_https: true,           # use HTTPS for lookup requests? (if supported)
  api_key: Rails.application.credentials.dig(Rails.env.to_sym, :google, :gmaps_api_key),
  units: :km                 # :km for kilometers or :mi for miles
)
