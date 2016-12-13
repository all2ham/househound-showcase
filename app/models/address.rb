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

class Address < ActiveRecord::Base
  belongs_to :listing

  validates :line_1, presence: true
  validates :city, presence: true
  validates :state_province, presence: true
  validates :zip_postcode, presence: true
  validates :country, presence: true

  before_validation :default_params

  def default_params
    self.country ||= "Canada"
  end

  def to_s
    "#{self.line_1}\n#{self.city}, #{self.country}\n#{self.zip_postcode}"
  end

end
