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

class Garage < Room

  PROPERTIES = {
    :size => :integer,
    :square_footage => :float
  }

  hstore_accessor :properties, PROPERTIES

end
