require 'rails_helper'

describe Api::V1::BaseController do

  before(:each) do
    @user = create(:buyer)
    @session = create(:session, user: @user)
    request.headers['Authorization'] = "Token token=#{@session.access_token}"
  end

  it 'should restrict access' do
    request.headers['Authorization'] = nil
    get 'restricted'
    expect(response).to have_http_status(401)
  end

  it 'should correctly authenticate' do
    get 'restricted'
    expect(response).to have_http_status(200)
  end

  it 'should set the current user' do
    get 'restricted'
    expect(assigns(:current_user)).to eq(@user)
  end

  it 'should return 419 if the token has expired' do
    @session.expires_at = DateTime.now - 1.minute
    @session.save!
    get 'restricted'
    expect(response).to have_http_status(419)
  end
end
