class AddStatusToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :status, :integer, default: 0
  end
end
