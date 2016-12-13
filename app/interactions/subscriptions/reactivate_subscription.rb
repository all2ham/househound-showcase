class ReactivateSubscription < ActiveInteraction::Base

  object :subscription, class: Subscription
  object :plan, class: Plan, default: nil

  def execute
    begin
      if subscription.active_until_period_end?

        result = compose(
          ReactivateStripeSubscription,
          stripe_subscription: stripe_subscription
        )

      else
        result = compose(
            CreateStripeSubscription,
            stripe_customer: stripe_customer,
            stripe_plan: stripe_plan
        )

        sub.assign_attributes(
            cancelled_on: nil,
            plan: plan,
            period_start: unix_to_datetime(stripe_sub.current_period_start),
            period_end: unix_to_datetime(stripe_sub.current_period_end),
            status: Subscription.statuses[:active],
            stripe_sub_id: stripe_sub.id,
            subscribed_on: DateTime.now
        )
      end

      subscription.status = Subscription.statuses[:active]
      subscription.cancelled_on = nil
      subscription.save!
    rescue StandardError => e
      errors.add(:subscription, "Failed to reactivate subscription - #{e.inspect}")
      Rails.logger.debug e.inspect
    end
  end

  private

  def stripe_customer
    # FetchStripeCustomer.run!(
    #                        stripe_customer_id: subscription.user.stripe_customer_id
    # )
    compose(
        FetchStripeCustomer,
        stripe_customer_id: subscription.user.stripe_customer_id
    )
  end

  def stripe_subscription
    compose(
        FetchStripeSubscription,
        stripe_customer: stripe_customer,
        stripe_subscription_id: subscription.stripe_sub_id
    )
  end

  def stripe_plan
    compose(
        FetchStripePlan,
        stripe_plan_id: plan.stripe_plan_id
    )
  end

  def valid_subscription?
    errors.add(:subscription, 'Must be active_until_period_end or cancelled') unless subscription.can_reactivate?
  end

  def unix_to_datetime(epoch)
    Time.at(epoch).utc.to_datetime
  end
end