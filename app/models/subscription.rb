class Subscription < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user
  belongs_to :plan

  enum status: {
      active: 0,
      cancelled: 1,
      delinquent: 2,
      active_until_period_end: 3
    }

  def can_cancel?
    active? || delinquent?
  end

  def can_reactivate?
    cancelled? || active_until_period_end?
  end

  def running?
    !cancelled?
  end

end
