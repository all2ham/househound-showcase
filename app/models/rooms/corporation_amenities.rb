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

class CorporationAmenities < Room

  PROPERTIES = {
    :bbq_allowed => :boolean,
    :billiard_room => :boolean,
    :concierge => :boolean,
    :controlled_entry => :boolean,
    :elevators => :boolean,
    :guest_suites => :boolean,
    :health_club => :boolean,
    :in_suite_laundry => :boolean,
    :library => :boolean,
    :on_site_superintendent => :boolean,
    :party_room => :boolean,
    :roof_top_deck => :boolean,
    :satellite_dish => :boolean,
    :sauna => :boolean,
    :security_guard => :boolean,
    :tennis_court => :boolean,
    :three_lines_water_system => :boolean,
    :water_softened => :boolean,
    :workshop => :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
