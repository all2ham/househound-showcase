class MigrateDevicesSubscriptionsToUsers < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :device_id, :user_id
    add_reference :devices, :user, index: true
  end
end
