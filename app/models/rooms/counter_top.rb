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

class CounterTop < Room

  PROPERTIES = {
    :caesar_stone => :boolean,
    :granite => :boolean,
    :marble => :boolean,
    :not_specific => :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
