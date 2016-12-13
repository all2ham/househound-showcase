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

class Parking < Room

  PROPERTIES = {
    :amount => :integer,
    :covered => :boolean,
    :none => :boolean,
    :open => :boolean,
    :underground => :boolean,
    :unrestricted => :boolean,
  }

  hstore_accessor :properties, PROPERTIES

end
