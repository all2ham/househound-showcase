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

class Listing < ActiveRecord::Base

  acts_as_paranoid

  LIMIT = 100

  BUILDING_TYPES = [
           :single_detached,
           :semi_detached,
           :townhouse,
           :link_house,
           :cottage_recreational,
           :mobile_home,
           :apartment_building
       ]

  BUILDING_STYLES = {
    "Bungalow" => 0,
    "Raised Bungalow" => 1,
    "Split Entry Bungalow" => 2,
    "1-1/2 Storey" => 3,
    "2 Or More Storeys" => 4,
    "Sidesplit" => 5,
    "Backsplit" => 6
  }

  enum building_type: BUILDING_TYPES


  BUILD_STEPS = %w(basic_info add_rooms add_photos)

  # scope :with_rooms_and_ratings, ->(user_id) { includes(rooms: [:user_room_ratings]).where(user_room_ratings: { user_id: user_id }) }
  scope :with_rooms_and_ratings, ->(user_id) { joins('LEFT OUTER JOIN rooms ON rooms.listing_id = listings.id').joins('LEFT OUTER JOIN user_room_ratings ON user_room_ratings.room_id = rooms.id').where('user_room_ratings.user_id = ?', user_id)}
  scope :with_rooms, -> { includes(:rooms) }
  scope :active, -> { where(active: true) }
  scope :not_active, -> { where(active: false) }

  # validates :step, inclusion: { in: BUILD_STEPS }, allow_nil: true

  validates :price, :property_taxes, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :floor_area, numericality: { greater_than_or_equal_to: 0}, allow_nil: false
  validates :expiry_date, presence: true
  validates :building_style, inclusion: { in: BUILDING_STYLES.values }
  validates :building_type, inclusion: { in: BUILDING_TYPES.map { |b| b.to_s } }
  validates :description, presence: true, length: { maximum: 2000 }

  #validates_associated :user, message: "You have reached your listing limit."
  validates_associated :address

	belongs_to :user

  has_one :address
  has_many :open_houses, dependent: :destroy
  has_many :follows
  has_many :users, through: :follows
  has_many :photos, as: :imageable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  has_many :rooms

  has_one :balcony
  has_one :basement
  has_many :bedrooms
  has_many :bathrooms
  has_one :common_room
  has_one :corporation_amenities
  has_one :counter_top
  has_one :fireplace
  has_one :floor
  has_one :garage
  has_one :kitchen
  has_one :luxury_room
  has_one :other
  has_one :outdoor_features
  has_one :parking
  has_one :pool

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :photos, allow_destroy: true

  accepts_nested_attributes_for :balcony, allow_destroy: true
  accepts_nested_attributes_for :basement, allow_destroy: true
  accepts_nested_attributes_for :bedrooms, allow_destroy: true
  accepts_nested_attributes_for :bathrooms, allow_destroy: true
  accepts_nested_attributes_for :common_room, allow_destroy: true
  accepts_nested_attributes_for :corporation_amenities, allow_destroy: true
  accepts_nested_attributes_for :counter_top, allow_destroy: true
  accepts_nested_attributes_for :fireplace, allow_destroy: true
  accepts_nested_attributes_for :floor, allow_destroy: true
  accepts_nested_attributes_for :garage, allow_destroy: true
  accepts_nested_attributes_for :kitchen, allow_destroy: true
  accepts_nested_attributes_for :luxury_room, allow_destroy: true
  accepts_nested_attributes_for :other, allow_destroy: true
  accepts_nested_attributes_for :outdoor_features, allow_destroy: true
  accepts_nested_attributes_for :parking, allow_destroy: true
  accepts_nested_attributes_for :pool, allow_destroy: true


  # Use Google API to generate QR Codes
  # Default height and width of 150px, can override
  def qr_code(height = 150, width = 150)

    @base_IP = Rails.application.secrets[:qr][:base_url]
    # @relative_url = "http://#{@base_IP}/#{}"

    # Start with base
    url = Rails.application.secrets[:qr][:google_base_url]

    # Add width/height
    url += "chs=#{width}x#{height}"

    # Add type of infographic (QR)
    url += "&cht=qr"

    # Add unique identifier for qr (in this case local to dev machine)

    url += "&chl=http://#{@base_IP}/#{self.id}"

    url
  end

  def agent_profile
    self.user.agent_profile
  end

  def average_room_rating
    rooms.joins(:user_room_ratings).where('user_room_ratings.score <> 0').average('user_room_ratings.score') || 0
  end

  def bedroom_count
    self.bedrooms.count
  end

  def b_type
    self.building_type
  end

  def next_open_house
    open_houses.where('start > ?', Time.now).order(start: :asc).first
  end

  def b_style
    BUILDING_STYLES.invert[self.building_type]
  end

  def bathroom_count
    count = 0
    self.bathrooms.each do |bathroom|
      count += bathroom.size
    end
    return count
  end

end
