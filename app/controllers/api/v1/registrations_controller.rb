# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      before_action :ensure_params_exist, only: :create
      skip_before_action :verify_authenticity_token, only: :create

      def create
        user = User.new user_params
        if user.save
          render json: {
            message: 'Sign up successful',
            user: user
          }, status: :ok
        else
          render json: {
            message: 'Something went wrong',
            user: {}
          }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :locale, :terms_of_use)
      end

      def ensure_params_exist
        return if params[:user].present?

        render json: {
          message: 'Credentials are wrong',
          user: {}
        }, status: :bad_request
      end
    end
  end
end
