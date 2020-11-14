# frozen_string_literal: true

FactoryBot.define do
  country_codes = %w[ar cn de en es fr hi jp pt ru]
  factory :user do
    traits_for_enum :role, %w[user vip admin]
    name { Faker::Name.first_name }
    email { "#{name.parameterize}.#{Faker::Name.last_name.parameterize}@example.com" }
    locale { country_codes.sample }
    terms_of_use { true }
    password { 'Some_password123#' }
    password_confirmation { 'Some_password123#' }
    created_at { Time.now.yesterday }
    confirmed_at { Time.now.yesterday + 5.minutes }
  end
end
