require 'rails_helper'

describe Api::V1::SessionsController do
  describe 'POST#create' do

    before(:each) do
      @user = create(:user)
      @params = {
        format: :json,
        user: {
          email: @user.email,
          password: @user.password
        },
        session: {
          os: Session::OS_TYPES.sample,
          uuid: Faker::Lorem.characters(10),
          push_token: Faker::Lorem.characters(10)
        }
      }
    end

    it 'should correctly authenticate a user' do
      post 'create', @params
      expect(response.code).to eq('200')
    end

    it 'should not let a user in with invalid credentials' do
      @params[:user][:password] = nil
      post 'create', @params
      expect(response.code).to eq('401')
    end

    it 'should return 422 when no user params supplied' do
      @params.delete(:user)
      post 'create', @params
      expect(response.code).to eq('422')
    end

    it 'should create a new api key when no valid ones exist' do
      old_session = create(:session, user: @user)
      old_session.expires_at = DateTime.now - 30.days
      old_session.save!
      expect(@user.sessions.count).to eq(1)
      post 'create', @params
      expect(@user.sessions.count).to eq(2)

      expect(old_session.access_token).not_to eq(@user.active_session(@params[:session][:os]).access_token)
    end
  end


  describe 'Existing session management' do
    before(:each) do
      @buyer = create(:buyer)
      @session = @buyer.sessions.first
      request.headers['Authorization'] = "Token token=#{@session.access_token}"
    end
    describe 'PATCH#update' do
      it 'should update a session' do
        new_uuid = SecureRandom.hex(10)
        new_push_token = SecureRandom.hex(10)
        new_os = Session::OS_TYPES.sample
        new_os_version = SecureRandom.hex(5)
        @params = {
          format: :json,
          session: {
            uuid: new_uuid,
            push_token: new_push_token,
            os: new_os,
            os_version: new_os_version
          }
        }
        patch :update, @params
        @session.reload
        expect(@session.uuid).to eq(new_uuid)
        expect(@session.push_token).to eq(new_push_token)
        expect(@session.os).to eq(new_os)
        expect(@session.os_version).to eq(new_os_version)
      end
    end

    describe 'DELETE#delete' do
      it "should delete a session" do
        expect(Session.count).to eq(1)
        delete :destroy
        expect(Session.count).to eq(0)
      end
    end
  end
end
