module Api
  module V1
    class PasswordsController < Devise::PasswordsController
      skip_before_action :verify_authenticity_token

      def reset
        user = User.find_by(email: user_params[:email])

        if user.present?
          user.generate_password_token!
          user.send_reset_password_instructions
        end

        render json: { status: 'E-mail sent to matching user if any was found.' }, status: :ok
      end

      def update
        token = user_params[:reset_password_token].to_s
        user = User.find_by(reset_password_token: token)
        if user.present? && user.password_token_valid?
          if user.reset_password!(user_params[:password])
            render json: { status: 'ok' } , adapter: :json, status: :ok
          else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
        end
      end
      
      private

      def user_params
        params.require(:user).permit(:password, :password_confirmation, :reset_password_token, :email)
      end
    end
  end
end
