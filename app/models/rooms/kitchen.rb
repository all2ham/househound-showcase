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

class Kitchen < Room

  PROPERTIES = {
    :appliance_count => :integer,
    :breakfast_bar => :boolean,
    :island => :boolean,
    :pantry => :boolean,
    :secondary_kitchen => :boolean,
    :square_footage => :float
  }

  hstore_accessor :properties, PROPERTIES

end
