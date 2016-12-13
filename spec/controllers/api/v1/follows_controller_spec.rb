require 'rails_helper'

describe Api::V1::FollowsController do

  it 'has a valid factory' do
    create(:follow)
  end

  context 'follows' do

    before(:each) do
      @params = {
        format: :json
      }
      @user = create(:buyer)
      @session = create(:session, user: @user)
      request.headers['Authorization'] = "Token token=#{@session.access_token}"
    end

    describe "GET index" do
      it 'can return a list of follows' do
        @rating = create(:user_room_rating, user: @user)
        @follow = create(:follow, user: @user, listing: @rating.room.listing)
        get :index, format: :json
        expect(assigns(:listings)).to include(@follow.listing)
      end
    end

    describe "POST create" do

      before(:each) do
        @listing = create(:listing)
      end

      it "should raise a 404 when non-existent listing id provided" do
        @params.merge!({
          listing_id: 4324252
        })
        post :create, @params
        expect(response).to have_http_status(404)
        expect(@user.follows.count).to eq(0)
      end

      it "should successfully follow with valid params" do
        @params.merge!({
          listing_id: @listing.id
        })
        post :create, @params
        expect(response).to have_http_status(200)
        expect(@user.follows.count).to eq(1)
      end

      it "should fail when a user is already following" do
        @follow = create(:follow, user: @user)
        @params.merge!({
          listing_id: @follow.listing_id
        })

        post :create, @params
        expect(response).to have_http_status(422)
        expect(@user.follows.count).to eq(1)
      end

      it "should return the listing" do
        @params.merge!({
          listing_id: @listing.id
        })

        post :create, @params

        expect(response).to have_http_status(200)
        expect(assigns(:listing)).to eq(@listing)
      end
    end

    describe "DELETE destroy" do
      it "should raise a 404 when non-existent follow id provided" do
        @params.merge!({
          id: 2342542
        })
        delete :destroy, @params
        expect(response).to have_http_status(404)
      end

      it "should unfollow properly" do
        @follow = create(:follow, user: @user)
        @params.merge!({
          listing_id: @follow.listing.id
        })
        expect(@user.follows.count).to eq(1)
        delete :destroy, @params

        expect(response).to have_http_status(200)
        expect(@user.follows.count).to eq(0)
      end
    end
  end
end
