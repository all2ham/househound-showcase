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

class Floor < Room

  PROPERTIES = {
    :hardwood => :boolean,
    :laminate => :boolean,
    :no_carpet => :boolean,
    :tile => :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
