require 'rails_helper'

RSpec.describe Api::V1::RoomsController do
  context 'ratings' do
    before(:each) do
      @user = create(:user)
      @session = create(:session, user: @user)
      @room = create(:room)
      @params = {
        format: :json,
        id: @room.id,
        score: (0..5).to_a.sample
      }
      request.headers['Authorization'] = "Token token=#{@session.access_token}"
    end
    it 'should create a rating and rate a room' do
      post :rate, @params
      expect(response).to have_http_status(200)
      expect(@room.user_room_ratings.count).to eq(1)
    end

    it 'should update an existing rating and rate a room' do
      rating = create(:user_room_rating, user: @user, room: @room)
      expect(@room.user_room_ratings).to include(rating)
      post :rate, @params
      rating.reload
      expect(response).to have_http_status(200)
      expect(@room.user_room_ratings.count).to eq(1)
      expect(rating.score).to eq(@params[:score])
    end
  end
end
