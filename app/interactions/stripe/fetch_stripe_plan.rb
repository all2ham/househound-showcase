class FetchStripePlan < ActiveInteraction::Base

  string :stripe_plan_id

  def execute
    Stripe::Plan.retrieve(stripe_plan_id)
  end
end
