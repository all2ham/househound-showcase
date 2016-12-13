class Listings::BuildController < ApplicationController
  include Wicked::Wizard

  respond_to :html

  steps *Listing::BUILD_STEPS

  before_action :authenticate_user!
  before_action :view_values, except: [:create]
  before_action :set_listing, only: [:show, :update, :upload]

  def show
    authorize! :manage, @listing
    set_shit_up
    render_wizard
  end

  def update
    authorize! :manage, @listing

    begin
      @listing.assign_attributes listing_params if params[:listing]

      unless @listing.active?
        if next_step == Wicked::FINISH_STEP
          @listing.step = nil
          @listing.active = true
        else
          @listing.step = steps[current_step_index + 1]
        end
      end

      @listing.save!

      flash[:notice] = t('listing.success')

      render_wizard @listing
    rescue StandardError => e
      set_shit_up

      flash[:error] = t('listing.error')

      render_wizard
    end
  end

  # Create a new listing if user wants to restart
  # Otherwise continue listing in progresss
  def create
    Listing.transaction do
      if params[:old_listing_id]
        # Destroy old listing that user restarted on
        current_user.listings.where(id: params[:old_listing_id]).each { |l| l.really_destroy! }
      end

      unless @listing = current_user.listing_in_progress
        @listing = Listing.new(user_id: current_user.id, step: steps.first)
        @listing.save!(validate: false)
      else
        flash[:notice] = t('listing.build.exists') if @listing.step.to_sym != steps.first
      end

      redirect_to wizard_path(@listing.step.to_sym, listing_id: @listing.id)
    end
  end

  def upload
    new_photo = @listing.photos.new
    new_photo.photo.key = params[:key]

    new_photo.save!

    render nothing: true
  end

  def edit
    redirect_to wizard_path(Listing::BUILD_STEPS.first, listing_id: params[:listing_id])
  end

  def finish_wizard_path
    listings_path
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_shit_up
    case step.to_sym
      when :basic_info
        set_basic_info
      when :add_rooms
        set_add_rooms
    end
  end

  def set_basic_info
    @address = @listing.address || @listing.build_address
  end

  def set_add_rooms
    @balcony = @listing.balcony || @listing.build_balcony
    @basement = @listing.basement || @listing.build_basement
    @common_room = @listing.common_room || @listing.build_common_room
    @corporation_amenities = @listing.corporation_amenities || @listing.build_corporation_amenities
    @counter_top = @listing.counter_top || @listing.build_counter_top
    @fireplace = @listing.fireplace || @listing.build_fireplace
    @floor = @listing.floor || @listing.build_floor
    @garage = @listing.garage || @listing.build_garage
    @kitchen = @listing.kitchen || @listing.build_kitchen
    @luxury_room = @listing.luxury_room || @listing.build_luxury_room
    @other = @listing.other || @listing.build_other
    @outdoor_features = @listing.outdoor_features || @listing.build_outdoor_features
    @parking = @listing.parking || @listing.build_parking
    @pool = @listing.pool || @listing.build_pool
  end

  def listing_params
    params.require(:listing).permit(
        :price,
        :description,
        :floor_area,
        :building_type,
        :building_style,
        :property_taxes,
        :expiry_date,
        address_attributes: [
            :id,
            :line_1,
            :line_2,
            :city,
            :state_province,
            :zip_postcode
        ],
        photos_attributes: [
            :id,
            :_destroy
        ],
        bathrooms_attributes: [
            :id,
            :context,
            :square_footage,
            :_destroy,
        ],
        bedrooms_attributes: [
            :id,
            :context,
            :square_footage,
            :_destroy,
        ],
        balcony_attributes: Balcony::PROPERTIES.keys + [:id],
        basement_attributes: Basement::PROPERTIES.keys + [:id],
        common_room_attributes: CommonRoom::PROPERTIES.keys + [:id],
        corporation_amenities_attributes: CorporationAmenities::PROPERTIES.keys + [:id],
        counter_top_attributes: CounterTop::PROPERTIES.keys + [:id],
        fireplace_attributes: Fireplace::PROPERTIES.keys + [:id],
        floor_attributes: Floor::PROPERTIES.keys + [:id],
        garage_attributes: Garage::PROPERTIES.keys + [:id],
        kitchen_attributes: Kitchen::PROPERTIES.keys + [:id],
        luxury_room_attributes: LuxuryRoom::PROPERTIES.keys + [:id],
        other_attributes: Other::PROPERTIES.keys + [:id],
        outdoor_features_attributes: OutdoorFeatures::PROPERTIES.keys + [:id],
        parking_attributes: Parking::PROPERTIES.keys + [:id],
        pool_attributes: Pool::PROPERTIES.keys + [:id],
    )
  end

  def view_values
    @current_step = current_step_index + 1 if current_step_index
    @total_steps = steps.count
    @progress_percentage = (@current_step / @total_steps.to_f) * 100 if @current_step && @total_steps
  end
end