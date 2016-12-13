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

class Pool < Room

  PROPERTIES = {
    :above_ground => :boolean,
    :indoor => :boolean,
    :in_ground => :boolean,
    :square_footage => :float
  }

  hstore_accessor :properties, PROPERTIES

end
