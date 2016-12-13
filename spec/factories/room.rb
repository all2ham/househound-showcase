require 'faker'

FactoryGirl.define do
  factory :room do
    after(:build) do |room, evaluator|
      room.listing ||= create(:listing)
    end
  end
end
