class CancelStripeSubscription
  def initialize(params)
    @stripe_subscription = params[:stripe_subscription]
  end

  def call
    begin
      @stripe_subscription.delete(subscription_attributes)
      return true
    rescue StandardError => e
      Rails::logger.debug e.inspect
      return false
    end
  end

  private

  def subscription_attributes
    {}
  end
end
