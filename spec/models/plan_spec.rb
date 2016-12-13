require 'rails_helper'

describe Plan do
  it 'should create a tax multiplier' do
    expect(Plan.tax_multiplier).to eq(1 + Plan.tax_percent.to_f / 100)
  end

  context 'pricing' do
    before(:each) do
      @plan = create(:plan)
    end

    it 'should have a subtotal' do
      expect(@plan.subtotal).to eq((@plan.price.to_f / 100).round(2))
    end

    it 'should have a total price' do
      calculated_total = (@plan.subtotal * Plan.tax_multiplier).round(2)
      expect(@plan.total_price).to eq(calculated_total)
    end

    it 'should have a stripe_total' do
      expect(@plan.stripe_total).to eq(@plan.total_price * 100)
    end
  end
end