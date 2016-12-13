class Api::V1::RoomsController < Api::V1::BaseController
  before_action :set_room

  def rate
    begin
      UserRoomRating.transaction do
        @rating = @room.user_room_ratings.where(user: current_user).first_or_create
        @rating.score = params[:score]
        @rating.save!

        render json: @rating
      end
    rescue Error::UnprocessableEntity => e
      render json: { message: "Unprocessable params - #{e.message}" }, status: 422
    rescue StandardError => e
      render json: { message: "Internal Server Error - #{e.message}" }, status: 500
    end
  end

  private

  def set_room
    begin
      @room = Room.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: "Room not found. - #{e.message}" }, status: 404
    rescue StandardError => e
      render json: { message: "Internal Server Error - #{e.message}" }, status: 500
    end
  end
end
