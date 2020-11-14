# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      before_action :set_event, only: %i[show update destroy]
      before_action :check_admin, only: %i[destroy]
      before_action :check_owner, only: %i[update]

      def index
        @events = Passenger.find(params[:passenger_id])
                           .events.published.includes([:user])
        render json: @events
      end

      def show
        render json: @event
      end

      def create
        # creates an Event for a logged user, a visitor
        passenger = Passenger.find_by(passenger_params)
        user = User.find_by(user_params)
        event = if passenger && current_user
                  Event.new(event_params_create.merge(passenger_id: passenger.id, user_id: current_user.id))
                elsif passenger && user
                  Event.new(event_params_create.merge(passenger_id: passenger.id, user_id: user.id))
                else
                  Event.new(event_params_create)
                end

        if event&.save
          render json: event, adapter: :json, status: 201
        else
          render json: { error: event.errors }, status: 422
        end
      end

      def update
        if @event.update(event_params_update)
          render json: @event, adapter: :json, status: 200
        else
          render json: { error: @event.errors }, status: 422
        end
      end

      def destroy
        @event.destroy
        head 204
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      def passenger_params
        params.require(:passenger).permit(:shortcut)
      end

      def user_params
        params.require(:user).permit(:email)
      end

      def event_params_create
        params.require(:event).permit(:address, :photo)
      end

      def event_params_update
        params.require(:event).permit(:photo)
      end

      def check_owner
        return unless @event.user != current_user

        render json: {}, status: 403
      end
    end
  end
end
