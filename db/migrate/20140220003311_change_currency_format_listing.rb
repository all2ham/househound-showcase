class ChangeCurrencyFormatListing < ActiveRecord::Migration
  def change
    change_column :listings, :price, :decimal, :precision => 20, :scale => 2
  end
end
