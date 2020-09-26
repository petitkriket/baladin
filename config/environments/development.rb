# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.assets.debug = true

  config.action_mailer.smtp_settings = {
    user_name: Rails.application.credentials.dig(Rails.env.to_sym, :email, :username),
    password: Rails.application.credentials.dig(Rails.env.to_sym, :email, :password),
    domain: Rails.application.credentials.dig(:domain_name_short),
    address: Rails.application.credentials.dig(Rails.env.to_sym, :email, :host),
    port: Rails.application.credentials.dig(Rails.env.to_sym, :email, :port),
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # ActionMailer Config
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = false

  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  # config.action_view.raise_on_missing_translations = true

  # Bullet n+1 queries
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
  end
end
