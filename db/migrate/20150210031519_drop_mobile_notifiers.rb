class DropMobileNotifiers < ActiveRecord::Migration
  def change
    drop_table :mobile_notifiers
  end
end
