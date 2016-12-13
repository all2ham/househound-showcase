class OpenHousesController < ApplicationController

  before_action :set_listing

  def index
    @open_houses = @listing.open_houses
  end

  def show
  end

  def new
    @open_house = @listing.open_houses.new
  end

  def create
    if @listing.open_houses.create(open_house_params)
      flash[:notice] = t('open_house.success')
      redirect_to listing_open_houses_path
    else
      flash[:error] = t('open_house.error')
      render action: :new
    end
    #render json: params
  end

  def edit
    @open_house = OpenHouse.find(params[:id])
    @listing = @open_house.listing
  end

  def update
    @open_house = OpenHouse.find(params[:id])

    if @open_house.update open_house_params
      flash[:notice] = t('open_house.updated')
      redirect_to listing_open_houses_path
    else
      render action: :edit
    end
  end

  def destroy
    OpenHouse.find(params[:id]).destroy
    flash[:notice] = t('open_house.delete.success')
    redirect_to listing_open_houses_path
  end

  protected

  def open_house_params
    params.require(:open_house).permit(:start, :end)
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
