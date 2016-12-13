class CreateStripeSubscription < ActiveInteraction::Base

  object :stripe_customer, class: Stripe::Customer
  object :stripe_plan, class: Stripe::Plan
  object :stripe_token, class: Stripe::Token, default: nil

  def execute
    stripe_customer.subscriptions.create(subscription_attributes)
  rescue StandardError => e
    errors.add(:stripe_customer, "Failed to create subscription #{e.inspect}")
  end

  private

  def subscription_attributes
    attrs = {
      plan: stripe_plan.id,
      tax_percent: Plan.tax_percent
    }

    attrs.merge(
             source: stripe_token.id
    ) if stripe_token
  end
end
