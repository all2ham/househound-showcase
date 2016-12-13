class AddApiTokenToUser < ActiveRecord::Migration
  def change
    remove_column :devices, :api_token, :string
    add_column :users, :api_token, :string, index: true
  end
end
