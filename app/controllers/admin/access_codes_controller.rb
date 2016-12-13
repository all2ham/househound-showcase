class Admin::AccessCodesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_access_code, only: [:destroy]

  load_and_authorize_resource

  def index
    @access_codes = AccessCode.includes(:versions).all
  end

  def show
    @access_code = AccessCode.includes(:users).find(params[:id])
  end

  def new
    @access_code = AccessCode.new
  end

  def create
    @access_code = AccessCode.new(access_code_params)

    if @access_code.save
      flash[:notice] = t('access_code.success', code: @access_code.code, limit: @access_code.limit)
      redirect_to admin_access_codes_path
    else
      flash[:error] = t('model.invalid')
      render action: :new
    end
  end

  def destroy
    @access_code.destroy
    flash[:notice] = t('access_code.destroy')
    redirect_to admin_access_codes_path
  end

  private

  def set_access_code
    @access_code = AccessCode.find(params[:id])
  end

  def access_code_params
    params.require(:access_code).permit(:code, :limit, :notes)
  end
end
