Webpacker::Compiler.env['GOOGLE_MAPS_JS_KEY'] = Rails.application.credentials.dig(Rails.env.to_sym, :google, :gmaps_js_api_key)
Webpacker::Compiler.env['MAPBOX_TOKEN'] = Rails.application.credentials.dig(Rails.env.to_sym, :mapbox, :api_token)
