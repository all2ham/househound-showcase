class AddIndexToUsersAccessCodeId < ActiveRecord::Migration
  def change
    add_index :users, :access_code_id
  end
end
