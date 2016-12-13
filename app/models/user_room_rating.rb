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

class UserRoomRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  MIN_SCORE = 0
  MAX_SCORE = 5

  scope :with_user_id, ->(user_id) { where(user_id: user_id) }

  validates :score, inclusion: { in: MIN_SCORE..MAX_SCORE }
  validates :user_id, uniqueness: { scope: :room_id }
end
