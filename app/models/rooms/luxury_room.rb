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

class LuxuryRoom < Room

  PROPERTIES = {
    :bar => :boolean,
    :entertainment_room => :boolean,
    :exercise_room => :boolean,
    :games_tables => :boolean,
    :sauna => :boolean,
    :studio => :boolean,
    :sun_room => :boolean,
    :theatre_room => :boolean,
    :wine_cellar => :boolean,
    :workshop => :boolean
  }

  hstore_accessor :properties, PROPERTIES

end
