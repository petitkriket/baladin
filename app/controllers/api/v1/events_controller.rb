# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      before_action :set_event, only: %i[show update destroy]
      before_action :check_admin, only: %i[create update destroy]

      def index
        @events = Passenger.find(params[:passenger_id]).events.includes([:user])
        render json: @events
      end

      def show
        render json: @event
      end

      def create
        event = Event.new(event_params)
        if event.save
          render json: event, adapter: :json, status: 201
        else
          render json: { error: event.errors }, status: 422
        end
      end

      def update
        if @event.update(event_params)
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

      def event_params
        params.require(:event).permit(
          :address, :city, :country, :latitude, :longitude,
          :photo, :published, :passenger_id, :user_id,
          :created_at
        )
      end
    end
  end
end
