class AddUidToListing < ActiveRecord::Migration
  def change
    add_column :listings, :uid, :string
    add_index :listings, :uid, unique: true
  end
end
