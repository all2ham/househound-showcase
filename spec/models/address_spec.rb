# == Schema Information
#
# Table name: addresses
#
#  id             :integer          not null, primary key
#  line_1         :string(255)
#  line_2         :string(255)
#  city           :string(255)
#  state_province :string(255)
#  zip_postcode   :string(255)
#  country        :string(255)
#  listing_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

describe Address do
  it 'has a valid factory' do
    create(:address)
  end
end
