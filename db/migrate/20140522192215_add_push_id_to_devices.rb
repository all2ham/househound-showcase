class AddPushIdToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :push_uid, :string
  end
end
