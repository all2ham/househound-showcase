require 'faker'

FactoryGirl.define do
  factory :address do
    line_1 Faker::Address.street_address
    city Faker::Address.city
    state_province Faker::Address.state
    zip_postcode Faker::Address.zip_code
    country Faker::Address.country

    listing
  end
end
