class AgentProfilesController < ApplicationController

  respond_to :html

  before_action :authenticate_user!
  before_action :set_agent_profile

  load_and_authorize_resource

  def show
  end

  def edit
  end

  def upload_photo
    AgentProfile.transaction do
      agent_profile = AgentProfile.find(params[:id])
      old_photo = agent_profile.photo
      new_photo = agent_profile.build_photo
      new_photo.photo.key = params[:key]
      new_photo.save!

      old_photo.destroy! if old_photo
    end

    render nothing: true
  end

  def update
    AgentProfile.transaction do
      if params[:photo]
        @agent_profile.photo ? @agent_profile.photo.update(image: params[:photo]) : @agent_profile.create_photo(image: params[:photo])
      end
      if @agent_profile.update(agent_profile_params)
        flash[:notice] = t('agent_profile.success')
        redirect_to agent_profile_path
      else
        flash[:error] = t('agent_profile.error')
        render :edit
      end
    end
  end

  private

  def agent_profile_params
    params.require(:agent_profile).permit(:name, :phone_number, :email, :website, :brokerage, :photo)
  end

  def set_agent_profile
    @agent_profile = current_user.agent_profile
  end

end
