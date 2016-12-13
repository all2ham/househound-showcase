require 'rails_helper'

describe '/api/v1/sessions/create' do
  it "should return api key" do
    user = create(:user)
    session = create(:session, user: user)
    assign(:user, user)
    assign(:user_session, session)
    render
    expect(rendered).to include(session.access_token)
  end
end