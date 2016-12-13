FactoryGirl.define do
  factory :session do
    association :user, factory: :buyer
    access_token { SecureRandom.urlsafe_base64(32) }
    expires_at { DateTime.now + 30.days }
    os { Session::OS_TYPES.sample }
    uuid { SecureRandom.hex(32) }
    push_token { SecureRandom.urlsafe_base64(32) }
  end

  factory :ios_session, parent: :session do
    os Session::IOS
  end

  factory :android_session, parent: :session do
    os Session::ANDROID
  end
end
