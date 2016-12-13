class Api::V1::ListingsController < Api::V1::BaseController

  before_action :set_listing

  def rooms
    @rooms = Room.includes(:user_room_ratings)
      .where(
        rooms: { listing_id: @listing.id },
        user_room_ratings: { user_id: [nil, current_user.id] }
      ).order(type: :asc)

    render json: @rooms, root: 'rooms', each_serializer: RoomSerializer
  end

  private

  def set_listing
    begin
      @listing = Listing.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Listing not found' }, status: 404
    end
  end


end
