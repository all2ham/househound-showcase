class CancelHouseHoundSubscription
  def initialize(params)
    @subscription = params[:subscription]
  end

  def call
    begin
      Subscription.transaction do
        @subscription.update_attributes(
          cancelled_on: DateTime.now,
          status: Subscription.statuses[:cancelled],
        )

        unless external_subscription_service.call
          raise ActiveRecord::Rollback
          return false
        end
      end

      return true
    rescue StandardError => e
      Rails::logger.error e.inspect
      return false
    end
  end

  private

  def external_subscription_service
    CancelStripeSubscription.new(
      stripe_subscription: external_subscription
    )
  end

  def external_subscription
    Stripe::Customer.retrieve(
      @subscription.user.stripe_customer_id
    ).subscriptions.retrieve(
      @subscription.stripe_sub_id
    )
  end
end
