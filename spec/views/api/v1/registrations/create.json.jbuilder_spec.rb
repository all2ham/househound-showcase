require 'rails_helper'

describe "api/v1/registrations/create.json.jbuilder" do

  it "should return the API key in the response" do
    user = create(:user)
    session = create(:session, user: user)
    assign(:user, user)
    assign(:user_session, session)
    render
    expect(rendered).to include(session.access_token)
  end

end
