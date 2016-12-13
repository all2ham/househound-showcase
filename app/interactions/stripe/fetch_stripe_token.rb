class FetchStripeToken < ActiveInteraction::Base

  string :token

  def execute
    Stripe::Token.retrieve(token)
  end
end
