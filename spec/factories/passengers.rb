# frozen_string_literal: true

FactoryBot.define do
  factory :passenger do
    sequence(:name, &:to_s)
    shortcut { Faker::Internet.unique.slug }
    photo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/factories/files/gray_placeholder.jpg'))) }

    created_at do
      Faker::Time.between(
        from: Faker::Time.backward(days: 1000, period: :morning),
        to: Faker::Time.backward(days: 1100, period: :morning)
      )
    end

    trait :without_photo do
      photo { nil }
    end
  end
end
