require 'rails_helper'

describe CreateStripeSubscription do
  context 'validations' do
    before(:each) do
      @params = {
        stripe_customer: Stripe::Customer.new,
        stripe_plan: Stripe::Plan.new,
        stripe_token: Stripe::Token.new
      }
    end

    it 'requires a Stripe::Customer' do
      @params.delete(:stripe_customer)
      expect {
        CreateStripeSubscription.run!(@params)
      }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end

    it 'requires a Stripe::Plan' do
      @params.delete(:stripe_plan)
      expect {
        CreateStripeSubscription.run!(@params)
      }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end

    it 'requires a Stripe::Token' do
      @params.delete(:stripe_token)
      expect {
        CreateStripeSubscription.run!(@params)
      }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end

  context 'success' do
    before(:each) do
      @user = create(:user)
      @stripe_plan = stripe_plan
      @stripe_token = random_stripe_token
      @stripe_customer = CreateStripeCustomer.run!(user: @user)
      @params = {
        stripe_token: FetchStripeToken.run!(token: @stripe_token),
        stripe_customer: @stripe_customer,
        stripe_plan: @stripe_plan,
      }
      @stripe_subscription = CreateStripeSubscription.run!(@params)
    end

    it 'should return a Stripe::Subscription' do
      expect(@stripe_subscription).to be_an_instance_of(Stripe::Subscription)
    end

    it 'should set the stripe subscription to the correct plan' do
      expect(@stripe_subscription.plan.id).to eq(@stripe_plan.id)
    end

    it 'should set the stripe subscription to the correct customer' do
      expect(@stripe_subscription.customer).to eq(@stripe_customer.id)
    end

    it 'should set a tax percentage' do
      expect(@stripe_subscription.tax_percent).to eq(Plan.tax_percent)
    end
  end
end
