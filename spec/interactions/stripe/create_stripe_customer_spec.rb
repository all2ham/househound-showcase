require 'rails_helper'

describe CreateStripeCustomer do
  context 'validations' do
    it 'should have a User passed as input' do
      # expect(CreateStripeCustomer.run(email: 'a random string').valid?).not_to eq(true)
      expect(CreateStripeCustomer.run(user: nil).valid?).not_to eq(true)
    end
  end

  context 'stripe customer creation' do
    before(:each) do
      @user = create(:user)
      @stripe_customer = CreateStripeCustomer.run!(user: @user)
    end

    it 'should return a Stripe::Customer' do
      expect(@stripe_customer).to be_an_instance_of(Stripe::Customer)
    end

    it 'should return a Stripe::Customer with the same email' do
      expect(@stripe_customer.email).to eq(@user.email)
    end

    it 'should save the stripe_customer_id to the user' do
      expect(@user.stripe_customer_id).to eq(@stripe_customer.id)
    end
  end
end
