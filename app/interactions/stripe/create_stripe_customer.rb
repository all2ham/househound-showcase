# Creates a Stripe Customer and persists it to a User model
class CreateStripeCustomer < ActiveInteraction::Base

  object :user, class: User

  def execute
    begin
      stripe_customer = Stripe::Customer.create(customer_attributes)
      @user.stripe_customer_id = stripe_customer.id
      @user.save!
      stripe_customer
    rescue StandardError => e
      errors.add(:user, "Failed to create Stripe Customer with error: #{e.message}")
    end
  end

  private

  def customer_attributes
    {
      email: @user.email
    }
  end
end
