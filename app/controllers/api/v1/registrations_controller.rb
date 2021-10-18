# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      skip_before_action :verify_authenticity_token
      before_action :ensure_params_exist, only: :create
      before_action :authenticate_user!, only: %i[update destroy]
      before_action :set_user, only: %i[show update destroy]

      def create
        user = User.new user_params
        event = Event.new event_params
        event.user = user if user.valid?
        if event.save && user.save
          User.where(role: 'admin').each {|admin| NotifMailer.registration_email(user, admin).deliver }
          render json: { user: user, event: event }, status: :ok
        else
          render json: { user: user.errors, event: event.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params.except(:terms_of_use))
          bypass_sign_in(@user)
          render json: { user: @user }, status: :ok
        else
          render json: { user: {} }, status: :unprocessable_entity
        end
      end

      def show
        if @user
          render json: { user: @user }, status: :ok
        else
          render json: { user: {} }, status: :forbidden
        end
      end

      def destroy
        if @user.destroy
          render json: { user: {} }, status: :no_content
        else
          render json: { user: {} }, status: :forbidden
        end
      end

      private

      def set_user
        @user = User.find(current_user.id)
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :locale, :terms_of_use)
      end

      def event_params
        params.require(:event).permit(:passenger_id, :address, :photo) if params[:event]
      end

      def ensure_params_exist
        return if params[:user].present?

        render json: { message: 'Credentials are wrong', user: {} }, status: :bad_request
      end
    end
  end
end
