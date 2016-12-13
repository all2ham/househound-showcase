class RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters

  # def create
  #   build_resource(sign_up_params)
  #   AccessCode.transaction do
  #     # Validate access code before allowing user to sign up
  #     access_code = AccessCode.find_by(id: sign_up_params[:access_code_id])
  #     unless access_code && !access_code.consumed?
  #       set_flash_message(:error, :invalid_access_code)
  #       clean_up_passwords resource
  #       set_minimum_password_length
  #       respond_with resource, location: new_user_registration_url
  #     else
  #       super
  #     end
  #   end
  # end

  def after_update_path_for
    edit_user_registration_path
  end

  protected

  def build_resource(hash = nil)
    super
    self.resource.role = User::Groups::AGENT
  end

  private

  def valid_access_code?
    session[:access_code].present?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :remember_me, :access_code_id)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password)
    end
  end
end
