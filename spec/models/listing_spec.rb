# == Schema Information
#
# Table name: listings
#
#  id                 :integer          not null, primary key
#  price              :decimal(20, 2)
#  description        :text
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  expiry_date        :date
#  floor_area         :integer
#  building_type      :integer
#  building_style     :integer
#  property_taxes     :float
#  deleted_at         :datetime
#  step               :string(255)
#  active             :boolean          default("false"), not null
#

require 'rails_helper'

describe Listing do
  it 'has a valid factory' do
    create(:listing)
  end

  context 'validations' do
  end

end
