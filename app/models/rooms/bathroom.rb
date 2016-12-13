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

class Bathroom < Room

  TYPES = %w(ensuite full_bath half_bath)

  PROPERTIES = {
      :context => :string,
      :square_footage => :float
  }

  hstore_accessor :properties, PROPERTIES

  def size
    if self.context == TYPES[2]
      0.5
    else
      1
    end
  end

end
