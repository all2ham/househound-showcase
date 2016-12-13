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

class OutdoorFeatures < Room

  PROPERTIES = {
    :deck => :boolean,
    :fire_pit => :boolean,
    :pond_lake => :boolean,
    :porch_veranda => :boolean,
    :shed => :boolean,
    :vegetable_garden => :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
