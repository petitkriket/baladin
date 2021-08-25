# frozen_string_literal: true

module Api
  module V1
    class ContributionSerializer < ActiveModel::Serializer
      belongs_to :passenger
      attributes :id, :photo, :address, :city, :country, :published, :created_at

      class PassengerSerializer < ActiveModel::Serializer
        attributes :name, :id
      end
    end
  end
end
