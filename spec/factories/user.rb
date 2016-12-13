# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#  active                 :boolean          default(FALSE)
#

require 'faker'

FactoryGirl.define do
  factory :user do
    role User::Groups::AGENT
    email { Faker::Internet.email }
    password 'changeme'
  end

  factory :user_with_session, parent: :user do
    after(:create) do |user, evaulator|
      create_list(:session, 1, user: user) if user.sessions.empty?
      user.reload
    end
  end

  factory :base_agent, parent: :user do
    role User::Groups::AGENT
  end

  factory :agent, parent: :base_agent do
  end

  factory :unconfirmed_agent, parent: :base_agent do
  end

  factory :admin, parent: :user do
    role User::Groups::ADMIN
  end

  factory :buyer, parent: :user_with_session do
    role User::Groups::BUYER
  end

end
