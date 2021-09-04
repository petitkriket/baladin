# frozen_string_literal: true

module Api
  module V1
    class PassengersController < ApiController
      before_action :set_passenger, only: %i[show update destroy]
      before_action :is_user_admin?, only: %i[create update destroy]

      def index
        @passengers = Passenger.left_joins(:events)
                               .order(:id)
                               .where.not(events: { id: nil, published: [nil, false] })
                               .includes(last_validated_event: [:user])
                               .uniq
        render json: @passengers
      end

      def show
        render json: @passenger
      end

      def find_by_shortcut
        passenger = Passenger.find_by(shortcut: params[:shortcut])
        render json: passenger
      end

      def create
        passenger = Passenger.new(passenger_params)
        if passenger.save
          render json: passenger, adapter: :json, status: 201
        else
          render json: { error: passenger.errors }, status: 422
        end
      end

      def update
        if @passenger.update(passenger_params)
          render json: @passenger, adapter: :json, status: 200
        else
          render json: { error: @passenger.errors }, status: 422
        end
      end

      def destroy
        @passenger.destroy
        head 204
      end

      private

      def set_passenger
        @passenger = Passenger.find(params[:id])
      end

      def passenger_params
        params.require(:passenger).permit(:name, :shortcut, :photo)
      end
    end
  end
end
