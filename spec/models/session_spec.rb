# == Schema Information
#
# Table name: sessions
#
#  id           :integer          not null, primary key
#  access_token :string(255)
#  expires_at   :datetime
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  uuid         :string(255)
#  push_token   :string(255)
#  os           :string(255)
#  os_version   :string(255)
#

require 'rails_helper'

describe Session do
  it 'has a valid factory' do
    create(:session)
  end

  context 'validations' do
    before(:each) do
      @session = create(:session)
    end
    it 'should be active by default' do
      expect(@session.active?).to eq(true)
      expect(@session.expired?).to eq(false)
    end

    it 'should be able to be disabled' do
      @session.expires_at = DateTime.now - 1.minute
      expect(@session.active?).to eq(false)
      expect(@session.expired?).to eq(true)
    end

    it 'should be unique' do
      session2 = build(:session)
      session2.access_token = @session.access_token
      expect(session2.valid?).to eq(false)
    end

    it 'won\'t save without a uuid' do
      session = build(:session, uuid: nil)
      expect(session.valid?).to eq(false)
    end

    it 'needs to have a supported OSf' do
      session = build(:session, os: 'symbian')
      expect(session.valid?).to eq(false)
    end
  end

  context 'push token' do
    it 'should properly strip push token characters' do
      session = build(:session, os: Session::IOS, push_token: "< ab c d > e")
      session.save!
      expect(session.push_token).to eq("abcde")
    end
    it 'should properly strip out to blank string' do
      session = build(:session, os: Session::IOS, push_token: "< >< <> ")
      session.save!
      expect(session.push_token).to eq(nil)
    end
  end
end
