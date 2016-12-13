require 'faker'

FactoryGirl.define do
  factory :access_code do
    code { SecureRandom.urlsafe_base64 }
    limit 10
    notes 'Note'
  end
end
