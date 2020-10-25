# frozen_string_literal: true

class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_raven_context

  private

  def check_admin
    render json: { error: 'Unauthorized' }, status: 403 unless user_signed_in? && current_user.admin?
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: 'Not found' }, status: 404
  end
end
