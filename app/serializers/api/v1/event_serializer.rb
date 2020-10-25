# frozen_string_literal: true

module Api
  module V1
    class EventSerializer < ActiveModel::Serializer
      attributes :id, :photo, :city, :country, :latitude, :longitude, :user, :created_at

      def user
        UserSerializer.new(object.user, root: false)
      end
    end
  end
end
