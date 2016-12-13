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

class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :user_id, uniqueness: { scope: :listing_id }

  def self.limit
    50
  end
end
