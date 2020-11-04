module Concerns
  module AuthenticateStaging
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_staging, if: -> { Rails.env.staging? }
    end

    private

    def authenticate_staging
      authenticate_or_request_with_http_basic do |username, password|
        ActiveSupport::SecurityUtils.secure_compare(username, Rails.application.credentials.dig(:http_basic_username)) &
          ActiveSupport::SecurityUtils.secure_compare(password, Rails.application.credentials.dig(:http_basic_password))
      end
    end
  end
end
