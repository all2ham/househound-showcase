class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |exception|
    render_404
  end

	def after_sign_in_path_for(resource)
		case (current_user.role)
      when User::Groups::ADMIN
        admin_path
      when User::Groups::AGENT
        listings_path
      else
        edit_user_registration_path(current_user)
    end
  end

  private

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

end
