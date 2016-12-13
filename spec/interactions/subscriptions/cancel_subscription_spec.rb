require 'rails_helper'

describe CancelSubscription do
  context :validation do
    it 'should pass an active subscription'
  end

  context :success do
    it 'should cancel the subscription'
    it 'should set the status to cancelled'
    it 'should store the date of cancellation'
  end
end