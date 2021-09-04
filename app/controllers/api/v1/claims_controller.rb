# frozen_string_literal: true

module Api
  module V1
    class ClaimsController < ApiController
      before_action :set_passenger, only: %i[create]

      def create
        contact = Contact.new(claim_params)
        email = @passenger.last_validated_event.user.email
        contact.user = email
        contact.request = request

        if contact.deliver
           render json: t(:message_sent), adapter: :json, status: 201
        else
           render json: contact.errors, adapter: :json, status: 422
        end
      end

      private

      def set_passenger
        @passenger = Passenger.find(params[:passenger_id])
      end

      def claim_params
        params.require(:claim).permit(:name, :email, :message, :nickname)
      end
    end
  end
end
