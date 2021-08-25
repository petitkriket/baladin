# frozen_string_literal: true

class ApiController < ActionController::Base
  include Concerns::AuthenticateStaging
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  before_action :set_raven_context

  private

  def is_user_admin?
    render json: { error: 'Unauthorized' }, status: 403 unless user_signed_in? && current_user.admin?
  end

  def is_user_signed_in?
    render json: { error: 'Unauthorized' }, status: 403 unless user_signed_in?
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: 'Not found' }, status: 404
  end
end
