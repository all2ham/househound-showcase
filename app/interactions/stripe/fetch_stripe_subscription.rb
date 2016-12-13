class FetchStripeSubscription < ActiveInteraction::Base

  object :stripe_customer, class: Stripe::Customer
  string :stripe_subscription_id


  def execute
    stripe_subscription = stripe_customer.subscriptions.retrieve(stripe_subscription_id)

    unless stripe_subscription
      errors.add(:stripe_subscription, 'Subscription Not Found')
    end
  end
end