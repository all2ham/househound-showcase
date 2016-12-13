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

class CommonRoom < Room

  PROPERTIES = {
    den: :boolean,
    dining_room: :boolean,
    laundry_room: :boolean,
    linen_closet: :boolean,
    living_room: :boolean,
    lounge: :boolean,
    office_study: :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
