class FetchStripeCustomer < ActiveInteraction::Base

  string :stripe_customer_id

  def execute
    Stripe::Customer.retrieve(stripe_customer_id)
  end
end