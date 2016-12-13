class RoomSerializer < ActiveModel::Serializer
  attributes :id, :properties, :type

  has_many :user_room_ratings, serializer: UserRoomRatingSerializer

  def type
    ActiveSupport::Inflector.titleize(object.type)
  end

end
