# == Schema Information
#
# Table name: user_room_ratings
#
#  id         :integer          not null, primary key
#  score      :integer
#  user_id    :integer
#  room_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe UserRoomRating do
  it "has a valid factory" do
    create(:user_room_rating)
  end

  context "validations" do
    it "should validate score range in 0 to 5" do
      rating = build(:user_room_rating)
      rating.score = 6
      expect(rating).to_not be_valid

      rating.score = -1
      expect(rating).to_not be_valid

      rating.score = UserRoomRating::MAX_SCORE
      expect(rating).to be_valid
    end
  end
end
