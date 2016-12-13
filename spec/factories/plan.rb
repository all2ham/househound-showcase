FactoryGirl.define do
  factory :plan do
    name { Faker::Lorem.word }
    price { Faker::Number.between(100, 5000) }
    stripe_plan_id { Faker::Lorem.word }
  end
end
