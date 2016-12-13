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

class Balcony < Room

  PROPERTIES = {
    enclosed: :boolean,
    none: :boolean,
    open: :boolean,
    terrace: :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
