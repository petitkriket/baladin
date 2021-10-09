module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      skip_before_action :verify_authenticity_token

      def reset
        user = User.find_by(email: user_params[:email])
        user.send_confirmation_instructions if user.present?

        render json: { status: 'E-mail sent to matching user if any was found.' }, status: :ok
      end

      def confirm
        token = params[:confirmation_token].to_s
        user = User.find_by(confirmation_token: token)
        if user.present?
          if user.confirm
            sign_in(user)
            render json: { user: user }, status: :ok
          else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error:  ['Confirmation token invalid or expired. Generate a new token.']}, status: :not_found
        end
      end
      
      private

      def user_params
        params.require(:user).permit(:confirmation_token, :email)
      end
    end
  end
end
