# frozen_string_literal: true

module Api
  module V1
    class EventSerializer < ActiveModel::Serializer
      attributes :id, :passenger_id, :photo, :city, :country, :latitude, :longitude, :user, :created_at

      def user
        UserSerializer.new(object.user, root: false) if object.user
      end
    end
  end
end
