class ChangeListingExpiryToDate < ActiveRecord::Migration
  def change
    change_column :listings, :expiry_date, :date
  end
end
