class Api::V1::FollowsController < Api::V1::BaseController

  before_action :set_listing, only: [:create]

  def index
    # Note N+1 query exists with user ratings, need to refactor
    @listings = current_user.listing_follows
  end

  def create
    begin
      raise Error::UnprocessableEntity, "Exceeded listing subscription limit." unless current_user.can_follow?(1)
      Follow.transaction do
        prev_follows = current_user.follows.pluck(:listing_id)
        raise Error::UnprocessableEntity, "You are already subscribed." if prev_follows.include?(params[:listing_id])

        current_user.follows.create!(listing_id: params[:listing_id])
      end
    rescue Error::UnprocessableEntity => e
      render json: { message: "Unprocessable params - #{e.message}"}, status: 422
    rescue StandardError => e
      render json: { message: "Internal Server Error - #{e.message}" }, status: 500
    end
  end

  def destroy
    begin
      Follow.transaction do
        @follow = current_user.follows.find_by!(listing_id: params[:listing_id])
        @follow.destroy!

        render nothing: true
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: "Subscription Not Found - #{e.message}" }, status: 404
    rescue StandardError => e
      render json: { message: "Internal Server Error - #{e.message}" }, status: 500
    end
  end

  private

  def set_listing
    begin
      @listing = Listing.includes(:rooms).find(params[:listing_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: "Listing not found - #{e.message}" }, status: 404
    rescue StandardError => e
      render json: { message: "Internal Server Error - #{e.message}" }, status: 500
    end
  end

end
