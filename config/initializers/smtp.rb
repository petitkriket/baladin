# frozen_string_literal: true

# https://github.com/fgrehm/letter_opener_web
# https://devcenter.heroku.com/articles/mailtrap

if Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener_web
end

if Rails.env.staging?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    user_name: Rails.application.credentials.dig(Rails.env.to_sym, :email, :username),
    password: Rails.application.credentials.dig(Rails.env.to_sym, :email, :password),
    address: Rails.application.credentials.dig(Rails.env.to_sym, :email, :host),
    port: Rails.application.credentials.dig(Rails.env.to_sym, :email, :port),
    authentication: :plain
  }
end

if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    user_name: Rails.application.credentials.dig(Rails.env.to_sym, :email, :username),
    password: Rails.application.credentials.dig(Rails.env.to_sym, :email, :password),
    address: Rails.application.credentials.dig(Rails.env.to_sym, :email, :host),
    domain: Rails.application.credentials.dig(:domain_name_short),
    port: Rails.application.credentials.dig(Rails.env.to_sym, :email, :port),
    authentication: :plain
  }
end
