# frozen_string_literal: true

require './spec/support/location_generator_helper'
FactoryBot.define do
  factory :event do
    passenger { nil }
    user { nil }
    address { location['street'] }
    city { location['city'] }
    country { location['country'] }
    latitude { location['latitude'] }
    longitude { location['longitude'] }
    published { true }
    created_at { Time.now }

    trait :pending do
      published { false }
    end

    transient do
      location { LocationGeneratorHelper.random_location }
    end

    to_create { |instance| instance.save(validate: false) }
  end
end
