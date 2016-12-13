# == Schema Information
#
# Table name: follows
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  listing_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Follow do
  it 'should have a valid factory' do
    create(:follow)
  end

  it 'should be unique based on <user, listing>' do
    follow = create(:follow)
    dup_follow = build(:follow, user: follow.user, listing: follow.listing)
    expect(dup_follow.valid?).to eq(false)
  end
end
