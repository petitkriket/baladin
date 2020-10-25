# frozen_string_literal: true

class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token

  private

  def check_admin
    render json: { error: 'Unauthorized' }, status: 403 unless user_signed_in? && current_user.admin?
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: 'Not found' }, status: 404
  end
end
