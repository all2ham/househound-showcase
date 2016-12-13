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

class Bedroom < Room

  TYPES = %w(master_bedroom general_bedroom nursery guest_bedroom walk-in_closet)

  PROPERTIES = {
    :context => :string,
    :square_footage => :float
  }

  hstore_accessor :properties, PROPERTIES

end
