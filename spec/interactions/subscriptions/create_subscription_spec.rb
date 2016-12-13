require 'rails_helper'

describe CreateSubscription do
  context :validation do
    it 'should require a plan'
    it 'should require a user'
    it 'should check for an existing subscription'
  end

  context :success do
    it 'should create a subscription'
    it 'should have a period start'
    it 'should have a period end 1 month after period start'
    it 'should have an active status'
    it 'should have a stripe subscription id'
    it 'should have a subscribed on day'
  end
end