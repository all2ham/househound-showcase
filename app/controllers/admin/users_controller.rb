class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # actions :index, :edit, :update, :destroy

  def update
    update! do |success, failure|
      success.html { admin_users_path }
    end
  end
end
