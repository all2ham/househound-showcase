class ListingsController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!

  def show
    require 'prawn'
    @listing = Listing.includes(rooms: [:user_room_ratings]).find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        poster_type = params[:poster_type]
        klass = case poster_type
                  when 'light'
                    PosterLight
                  else
                    PosterPdf
                  end
        pdf = klass.new(@listing, view_context)
        send_data pdf.render, filename: "#{@listing.address.line_1}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end


  def index
    @active_listings = current_user.listings.includes(:address).active
    @incomplete_listings = current_user.listings.not_active
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy!

    flash[:notice] = t('listing.deleted')

    redirect_to listings_path
  end
end
