class AddSubscribedOnToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscribed_on, :datetime
  end
end
