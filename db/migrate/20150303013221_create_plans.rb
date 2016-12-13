class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :price
      t.string :stripe_plan_id
      t.timestamps null: false
    end

    add_reference :subscriptions, :plan
  end
end
