class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_subscription

  def show
    redirect_to new_subscription_path unless @subscription
  end

  def new
    if @subscription && !@subscription.can_reactivate?
      flash[:error] = t('subscription.exists')
      redirect_to subscription_path(current_user.subscription)
    end
  end

  def create
    if @subscription && !@subscription.can_reactivate?
      flash[:error] = t('subscription.exists')
      redirect_to subscription_path(current_user.subscription)
    end

    result = CreateHouseHoundSubscription.new(
      plan: params[:stripe_plan_id],
          user: current_user,
          token: params[:stripeToken]
      ).call

    if result
      flash[:notice] = t('subscription.creation.success', plan: result.plan.name, price: result.plan.total_price)
    else
      flash[:error] = t('subscription.creation.failure')
    end

    redirect_to subscription_path
  end

  def cancel
    unless @subscription.can_cancel?
      flash[:error] = t('subscription.nonexistent')
      redirect_to new_subscription_path
    end

    if CancelHouseHoundSubscription.new(subscription: @subscription).call
      flash[:notice] = t('subscription.cancellation.success')
      redirect_to unauthenticated_root_path
    else
      flash[:error] = t('subscription.cancellation.failure')
      redirect_to subscription_path
    end
  end

  private

  def set_subscription
    @subscription = current_user.subscription
  end

end
