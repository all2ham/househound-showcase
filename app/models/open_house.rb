# == Schema Information
#
# Table name: open_houses
#
#  id         :integer          not null, primary key
#  date       :datetime
#  listing_id :integer
#  created_at :datetime
#  updated_at :datetime
#  start_time :time
#  end_time   :time
#

class OpenHouse < ActiveRecord::Base
  belongs_to :listing

  validates :start, presence: true
  validates :end, presence: true

end
