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

class Other < Room

  PROPERTIES = {
    :central_air => :boolean,
    :central_vacuum => :boolean,
    :furnished => :boolean,
    :pets => :boolean
  }

  def self.selects(key)
    key = key.symbolize unless key.is_a?(Symbol)
    case key
    when :pets
      return %w(yes no restricted limited)
    end
  end

  hstore_accessor :properties, PROPERTIES

end
