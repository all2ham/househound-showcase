class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.datetime :expires_at
      t.belongs_to :user, index: true

      t.timestamps
    end

    add_index :api_keys, :access_token, unique: true

    remove_column :users, :api_token, :string
  end
end
