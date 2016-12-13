class Api::V1::BaseController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  before_action :authenticate_api!

  around_action :error_wrap

  def restricted
    render json: { message: "Access granted." }
  end

  private

  def authenticate_api!
    authenticate_or_request_with_http_token do |token, options|
      @session = Session.where(access_token: token).take

      if @session
        if @session.expired?
          render json: { message: "API token has expired. Please login again." }, status: 419
        else
          @current_user = @session.user
        end
      else
        render json: { message: "Access not authorized." }, status: 401
      end
    end
  end

  def current_user
    @current_user
  end

  def current_session
    @session
  end

  def error_wrap
    begin
      yield
    rescue StandardError => e
      render json: { message: "An error occurred: #{e.message}"}, status: :internal_server_error
    end
  end
end
