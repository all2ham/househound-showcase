class Api::V1::RegistrationsController < Api::V1::BaseController

  skip_before_filter :authenticate_api!, only: [:create]

  before_filter :check_params_present

  def create
    User.transaction do
      begin
        @user = User.new_buyer(user_params)

        @user_session = @user.sessions.create(device_params)

        @user.save!

      rescue ActiveRecord::RecordInvalid => e
        render json: { message: "An error occurred" }, status: 422
      rescue Exception => e
        render json: { message: e.message }, status: 422
      end
    end

  end

  private

  def check_params_present
    return unless params[:user].blank?

    render json: {
      success: false,
      message: "Valid parameters not supplied"
    }, status: 422
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def device_params
    params.require(:device).permit(:push_token, :os, :os_version, :uuid)
  end

end
