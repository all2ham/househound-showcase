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

require 'spec_helper'

describe OpenHouse do
end
