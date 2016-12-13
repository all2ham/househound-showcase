class Api::V1::SessionsController < Api::V1::BaseController

  skip_before_filter :authenticate_api!, only: [:create]

  before_filter :ensure_params_exist, only: [:create]

  def create
    @user = User.where(
      email: user_params[:email]
    ).take

    if @user && @user.valid_password?(user_params[:password])

      # Check for valid session, and create if necessary
      @user_session = @user.active_session(session_params[:os])
      if @user_session == nil
        @user_session = @user.sessions.create!(session_params)
      end
    else
      return invalid_login_attempt
    end
  end

  def update
    begin
      current_session.update!(session_params)
      @user_session = current_session.reload
    rescue StandardError => e
      render json: { message: "An error occurred - #{e.message}" }, status: 500
    end
  end

  def destroy
    begin
      current_session.destroy!
      render json: {}
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: "Session not found. - #{e.message}" }, status: 404
    rescue StandardError => e
      render json: { message: "An error occurred - #{e.message}"}, status: 500
    end
  end

  private

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {
      success: false,
      message: "Valid parameters not supplied."
    }, status: 422
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def session_params
    params.require(:session).permit(:uuid, :os, :push_token, :os_version)
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: {
      success: false,
      message: "Your username or password is invalid."
    }, status: 401
  end
end
