FactoryGirl.define do
  factory :user_room_rating do
    score { (0..5).to_a.sample }

    after(:build) do |rating|
      rating.room ||= create(:room)
      rating.user ||= create(:user)
    end
  end
end
