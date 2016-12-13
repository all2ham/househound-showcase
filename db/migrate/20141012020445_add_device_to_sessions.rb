class AddDeviceToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :uuid, :string
    add_column :sessions, :push_token, :string
    add_column :sessions, :os, :string
    add_column :sessions, :os_version, :string
  end
end
