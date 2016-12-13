require 'rails_helper'

describe Api::V1::RegistrationsController do

  before(:each) do
    @user_attrs = attributes_for(:user)
    @session_attrs = attributes_for(:session)

    @params = {
      format: :json,
      user: @user_attrs,
      device: @session_attrs
    }

  end

  it "should fail when user exists" do
    User.create(@user_attrs)
    post 'create', @params
    expect(response.code).to eq("422")
  end

  it "should fail when session exists" do
    Session.create(@session_attrs)
    post 'create', @params
    expect(response.code).to eq("422")
  end

  it "should deny a user without an email" do
    @params[:user][:email] = nil
    post 'create', @params
    expect(response.code).to eq("422")
  end

  it "should deny a user without matching password" do
    @params[:user][:password] = nil
    post 'create', @params
    expect(response.code).to eq('422')
  end

  it "should create a user and session when supplied" do
    post 'create', @params
    expect(response.code).to eq("200")
    expect(User.where(email: @user_attrs[:email]).count).to eq(1)
    expect(Session.by_push_token(@session_attrs[:push_token])).not_to eq(nil)
  end
end
