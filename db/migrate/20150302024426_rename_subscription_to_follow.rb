class RenameSubscriptionToFollow < ActiveRecord::Migration
  def change
    remove_index :subscriptions, column: :listing_id
    remove_index :subscriptions, column: :user_id
    rename_table :subscriptions, :follows
    add_index :follows, [:listing_id]
    add_index :follows, [:user_id]
  end
end
