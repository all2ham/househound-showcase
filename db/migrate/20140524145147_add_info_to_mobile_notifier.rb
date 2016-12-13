class AddInfoToMobileNotifier < ActiveRecord::Migration
  def change
    remove_column :mobile_notifiers, :uid
    add_column :mobile_notifiers, :listing_id, :integer
    add_column :mobile_notifiers, :message, :text
    add_index :mobile_notifiers, :listing_id
  end
end
