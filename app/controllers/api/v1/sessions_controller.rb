# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      before_action :sign_in_params, only: :create
      before_action :load_user, only: :create
      skip_before_action :verify_authenticity_token, only: [:create, :destroy]

      def create
        if @user.valid_password?(sign_in_params[:password])
          sign_in 'user', @user
          render json: {
            message: 'Sign in successful',
            user: @user
          }, status: :ok
        else
          render json: {
            message: 'Something went wrong',
            user: {}
          }, status: :unauthorized
        end
      end

      def destroy
        if sign_out(resource_name)
          render json: {
            message: 'Sign out successful',
            user: {}
          }, status: :ok
        end
      end

      private

      def sign_in_params
        params.require(:user).permit :email, :password
      end

      def load_user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
        @user || render(json: {
                          messages: 'Something went wrong',
                          user: {}
                        }, status: :unauthorized)
      end
    end
  end
end
