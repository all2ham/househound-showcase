class CreateSubscriptionsOld < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :device, index: true
      t.belongs_to :listing, index: true

      t.timestamps
    end
  end
end
