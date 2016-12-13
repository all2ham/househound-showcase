FactoryGirl.define do
  factory :follow do
    association :user, factory: :buyer
    listing
  end
end
