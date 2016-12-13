class AddExpiryToListings < ActiveRecord::Migration
  def change
    add_column :listings, :expiry_date, :datetime
  end
end
