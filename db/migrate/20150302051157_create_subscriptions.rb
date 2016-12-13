class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_sub_id
      t.datetime :period_start
      t.datetime :period_end
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
  end
end
