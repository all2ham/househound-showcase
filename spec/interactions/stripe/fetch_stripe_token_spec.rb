require 'rails_helper'

describe FetchStripeToken do
  context 'validations' do
    it 'should expect a token parameter' do
      expect {
        FetchStripeToken.run!
      }.to raise_error(ActiveInteraction::InvalidInteractionError, 'Token is required')
    end
  end

  it 'should fetch the Stripe::Token' do
    token = random_stripe_token
    expect(
      FetchStripeToken.run!(token: token)
    ).to be_an_instance_of(Stripe::Token)
  end

  it 'the id should equal the token' do
    token = StripeMock.generate_card_token(last4: "9191", exp_year: 2017)
    expect(FetchStripeToken.run!(token: token).id).to eq(token)
  end
end
