host = if ENV['HEROKU_APP_NAME']
         ENV['HEROKU_APP_NAME'] + '.herokuapp.com'
       else
         'localhost:3000'
       end

protocol = if Rails.application.config.force_ssl || ENV['HEROKU_APP_NAME']
    'https'
  else
    'http'
  end

Rails.application.routes.default_url_options.merge!(
  host: host,
  protocol: protocol
)
