# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  listing_id :integer
#  created_at :datetime
#  updated_at :datetime
#  properties :hstore
#  type       :string(255)
#

class Room < ActiveRecord::Base

  # KINDS = %w(basement bathroom bedroom common_room counter_top fireplace floor garage kitchen luxury_room other outdoor_feature pool)

  # SELECTS = {
  #   pets: {
  #     allowed: %w(yes no restricted limited)
  #   }
  # }

  # KINDS = {
  #   balcony: {
  #     enclosed: :boolean,
  #     none: :boolean,
  #     open: :boolean,
  #     terrace: :boolean
  #   },
  #   basement: {
  #     square_footage: :float,
  #     finished: :boolean,
  #     licensed_rental: :boolean,
  #     walk_out: :boolean
  #   },
  #   common_room: {
  #     living_room: :boolean,
  #     dining_room: :boolean,
  #     lounge: :boolean,
  #     den: :boolean,
  #     office_study: :boolean,
  #     laundry_room: :boolean,
  #     linen_closet: :boolean
  #   },
  #   corporation_amenities: {
  #     :bbq_allowed => :boolean,
  #     :billiard_room => :boolean,
  #     :concierge => :boolean,
  #     :controlled_entry => :boolean,
  #     :elevators => :boolean,
  #     :guest_suites => :boolean,
  #     :health_club => :boolean,
  #     :in_suite_laundry => :boolean,
  #     :library => :boolean,
  #     :on_site_superintendent => :boolean,
  #     :party_room => :boolean,
  #     :roof_top_deck => :boolean,
  #     :satellite_dish => :boolean,
  #     :sauna => :boolean,
  #     :security_guard => :boolean,
  #     :tennis_court => :boolean,
  #     :three_lines_water_system => :boolean,
  #     :water_softened => :boolean,
  #     :workshop => :boolean
  #   },
  #   counter_top: {
  #     :marble => :boolean,
  #     :granite => :boolean,
  #     :caesar_stone => :boolean,
  #     :not_specific => :boolean
  #   },
  #   fireplace: {
  #     :none => :boolean,
  #     :gas => :boolean,
  #     :wood_burning => :boolean
  #   },
  #   floor: {
  #     :no_carpet => :boolean,
  #     :hardwood => :boolean,
  #     :laminate => :boolean,
  #     :tile => :boolean
  #   },
  #   garage: {
  #     :square_footage => :float,
  #     :size => :integer
  #   },
  #   kitchen: {
  #     :square_footage => :float,
  #     :appliance_count => :boolean,
  #     :island => :boolean,
  #     :breakfast_bar => :boolean,
  #     :pantry => :boolean,
  #     :secondary_kitchen => :boolean
  #   },
  #   luxury_room: {
  #     :theatre_room => :boolean,
  #     :entertainment_room => :boolean,
  #     :bar => :boolean,
  #     :wine_cellar => :boolean,
  #     :games_tables => :boolean,
  #     :exercise_room => :boolean,
  #     :sun_room => :boolean,
  #     :sauna => :boolean,
  #     :studio => :boolean,
  #     :workshop => :boolean
  #   },
  #   other: {
  #     :furnished => :boolean,
  #     :central_air => :boolean,
  #     :central_vacuum => :boolean,
  #     :pets => :select
  #   },
  #   outdoor_feature: {
  #     :deck => :boolean,
  #     :fire_pit => :boolean,
  #     :shed => :boolean,
  #     :vegetable_garden => :boolean,
  #     :pond_lake => :boolean,
  #     :porch_veranda => :boolean
  #   },
  #   parking_spots: {
  #     :amount => :integer,
  #     :covered => :boolean,
  #     :underground => :boolean,
  #     :open => :boolean,
  #     :unrestricted => :boolean,
  #     :none => :boolean
  #   },
  #   pool: {
  #     :square_footage => :float,
  #     :indoor => :boolean,
  #     :above_ground => :boolean,
  #     :in_ground => :boolean
  #   }
  # }

  # KINDS.each do |kind, attrs|
  #   attrs.each do |key, type|
  #     scope "has_#{key}", lambda { |value| where("properties @> hstore(? => ?)", key, value) }

  #     define_method(key) do
  #       properties && properties[key]
  #     end

  #     define_method("#{key}=") do |value|
  #       self.properties = (properties || {}).merge(key => value)
  #     end
  #   end
  # end

  belongs_to :listing

  has_many :user_room_ratings, dependent: :destroy

  def rating_average
    # sum = 0
    return "Not rated yet" unless user_room_ratings.present?
    user_room_ratings.inject(0.0) { |sum, x| sum + x.score }.to_f / user_room_ratings.count
  end

end
