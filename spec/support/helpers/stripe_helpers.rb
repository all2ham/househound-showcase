module StripeHelpers
  def random_stripe_token
    StripeMock.generate_card_token(last4: Faker::Number.number(4), exp_year: 2020)
  end

  def stripe_plan(id = Faker::Lorem.word, amount = Faker::Number.number(4))
    StripeMock.create_test_helper.create_plan(id: id, amount: amount)
  end
end
