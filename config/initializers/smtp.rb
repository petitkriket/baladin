# frozen_string_literal: true

# Action Mailer setup with mailing service (in addition to env setup).
ActionMailer::Base.smtp_settings = {
  domain: Rails.application.credentials.dig(:domain_name_short),
  address: Rails.application.credentials.dig(Rails.env.to_sym, :email, :host),
  port: Rails.application.credentials.dig(Rails.env.to_sym, :email, :port),
  authentication: :plain,
  user_name: Rails.application.credentials.dig(Rails.env.to_sym, :email, :username),
  password: Rails.application.credentials.dig(Rails.env.to_sym, :email, :password)
}
