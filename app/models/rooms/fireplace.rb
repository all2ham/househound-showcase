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

class Fireplace < Room

  PROPERTIES = {
    :gas => :boolean,
    :none => :boolean,
    :wood_burning => :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
