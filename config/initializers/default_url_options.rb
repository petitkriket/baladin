host = if ENV['HEROKU_APP_NAME']
         ENV['HEROKU_APP_NAME'] + '.herokuapp.com'
       else
         'localhost:3000'
       end

protocol = Rails.application.config.force_ssl ? 'https' : 'http'

Rails.application.routes.default_url_options.merge!(
  host: host,
  protocol: protocol
)
