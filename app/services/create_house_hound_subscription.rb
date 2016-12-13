class CreateHouseHoundSubscription
  def initialize(params)
    @user = params[:user]
    @plan = Plan.get(params[:plan])
    @stripe_plan = FetchStripePlan.run!(stripe_plan_id: @plan.stripe_plan_id)
    @stripe_token = FetchStripeToken.run!(token: params[:token])
    @stripe_customer = external_customer_object
  end

  def call
    begin
      raise SubscriptionError, 'User has an active subscription' if @user.has_active_subscription?

      stripe_sub = external_subscription_service

      sub = @user.subscription || @user.build_subscription
      sub.assign_attributes(
        cancelled_on: nil,
        plan: @plan,
        period_start: unix_to_datetime(stripe_sub.current_period_start),
        period_end: unix_to_datetime(stripe_sub.current_period_end),
        status: Subscription.statuses[:active],
        stripe_sub_id: stripe_sub.id,
        subscribed_on: DateTime.now
      )
      sub.save!
    rescue StandardError => e
      Rails::logger.error e.inspect
      return false
    end

    sub
  end

  private

  def unix_to_datetime(epoch)
    Time.at(epoch).utc.to_datetime
  end

  def external_customer_service
    CreateStripeCustomer.run!(
      user: @user
    )
  end

  def external_subscription_service
    CreateStripeSubscription.run!(
      stripe_plan: @stripe_plan,
      stripe_customer: @stripe_customer,
      stripe_token: @stripe_token
    )
  end

  def external_customer_object
    @user.stripe_customer_id ? Stripe::Customer.retrieve(@user.stripe_customer_id) : external_customer_service
  end
end
