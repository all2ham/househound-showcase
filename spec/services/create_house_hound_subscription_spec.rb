require 'rails_helper'

describe CreateHouseHoundSubscription do
  before { StripeMock.start }
  after { StripeMock.stop }

  let(:plan) { create(:plan) }
  let(:user) { create(:agent) }
  let(:service) { CreateHouseHoundSubscription.new({plan: plan, user: user, token: SecureRandom.urlsafe_base64}) }
  let(:customer_service) { instance_double(CreateStripeCustomer) }
  let(:stripe_customer) { Stripe::Customer.new }

  it 'should delete the Stripe customer if it fails to get the subscription'
  it 'should create a subscription'
end
