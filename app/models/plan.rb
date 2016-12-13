class Plan < ActiveRecord::Base
  FREE = 'free'
  PLUS = 'plus1'
  PREMIUM = 'premium1'

  has_many :subscriptions

  scope :get, -> (id) { find_by(stripe_plan_id: id) }
  scope :free, -> { find_by(stripe_plan_id: FREE) }
  scope :plus, -> { find_by(stripe_plan_id: PLUS) }
  scope :premium, -> { find_by(stripe_plan_id: PREMIUM) }

  def total_price
    (subtotal * Plan.tax_multiplier).round(2)
  end

  def subtotal
    (price.to_f / 100).round(2)
  end

  def stripe_total
    (price * Plan.tax_multiplier).round(0)
  end

  def self.tax_multiplier
    (1 + Plan.tax_percent.to_f / 100)
  end

  def self.tax_percent
    Rails.application.secrets[:stripe][:tax_percent]
  end
end
