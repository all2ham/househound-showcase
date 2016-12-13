class RenameTokensDevices < ActiveRecord::Migration
  def change
    rename_column :devices, :token, :api_token
    rename_column :devices, :push_uid, :push_token
    rename_column :devices, :uid, :uuid
  end
end
