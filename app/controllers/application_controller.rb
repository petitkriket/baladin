class ApplicationController < ActionController::Base
    # include Concerns::AuthenticateStaging
  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
