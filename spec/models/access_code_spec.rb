# == Schema Information
#
# Table name: access_codes
#
#  id           :integer          not null, primary key
#  batch_number :integer
#  access_code  :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe AccessCode do
  it 'should have a valid factory' do
    create(:access_code)
  end

  it 'should not be consumed without a user' do
    ac = create(:access_code)
    expect(ac.consumed?).to eq(false)
  end

  it 'should be consumed with a user' do
    ac = create(:access_code, limit: 1)
    user = create(:user, access_code: ac)
    expect(user.access_code.consumed?).to eq(true)
  end
end
