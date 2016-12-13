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
#  sign_in_count          :integer          default("0"), not null
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
#  active                 :boolean          default("false")
#

require 'rails_helper'

describe User do

  it "has a valid factory" do
    create(:user)
  end

  it "admin has a valid factory" do
    a = create(:admin)
    expect(a.is_admin?).to eq(true)
  end

  it "agent has a valid factory" do
    a = create(:agent)
    expect(a.is_agent?).to eq(true)
  end

  it "buyer has a valid factory" do
    b = create(:buyer)
    expect(b.is_buyer?).to eq(true)
  end

  it "has a unique email" do
    user1 = create(:user)
    expect(build(:user, email: user1.email)).not_to be_valid
  end

  it "default role is agent" do
    user = create(:user)
    expect(user.role).to eq("Agent")
  end

  it "should not let an agent be an admin" do
    agent = create(:agent)
    expect(agent.is_admin?).to eq(false)
  end

  it "should let an admin be an admin" do
    admin = create(:admin)
    expect(admin.is_admin?).to eq(true)
  end

  it "should not let a buyer be an admin" do
    buyer = create(:buyer)
    expect(buyer.is_admin?).to eq(false)
  end

end
