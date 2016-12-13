class Listings::NotificationsController < ApplicationController

  respond_to :html

  before_action :authenticate_user!
  before_action :set_listing, except: [:index]

  def index
    @listing = Listing.includes(:notifications).find(params[:listing_id])
    @notifications = @listing.notifications.order(created_at: :desc)
  end

  def new
  end

  def create
    notification = @listing.notifications.create! notification_params
    SendPushWorker.perform_async(notification.id)

    flash[:notice] = t('notification.success')
    redirect_to listing_notifications_path
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def notification_params
    params.require(:notification).permit(:message)
  end
end