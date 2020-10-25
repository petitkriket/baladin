# frozen_string_literal: true

module Api
  module V1
    class PassengerSerializer < ActiveModel::Serializer
      attributes :id, :name, :photo, :created_at
      has_one :last_validated_event
    end
  end
end
