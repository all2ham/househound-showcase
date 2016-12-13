# Reactivate a stripe subscription if it has been cancelled but is still active within the end of period time
class ReactivateStripeSubscription < ActiveInteraction::Base

  object :stripe_subscription, class: Stripe::Subscription
  object :stripe_plan, class: Stripe::Plan, default: nil

  def execute
    if stripe_plan?
      stripe_subscription.plan = stripe_plan.id
    end

    stripe_subscription.save!
    stripe_subscription
  rescue StandardError => e
    errors.add(:stripe_customer, "Failed to create subscription #{e.inspect}")
  end

end
