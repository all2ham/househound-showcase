require 'faker'

FactoryGirl.define do
  factory :listing do
    price { rand.to_s[2..9] }
    floor_area { rand.to_s[2..6] }
    expiry_date Time.now
    description Faker::Lorem.paragraph(1)
    step Listing::BUILD_STEPS.sample
    building_style Listing::BUILDING_STYLES.values.sample
    building_type Listing::BUILDING_TYPES.sample
    property_taxes { rand.to_s[2..5] }

    after(:build) do |listing|
      listing.address ||= build(:address, listing: listing)
    end
  end
end
