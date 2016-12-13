class AddSquareFootageToListing < ActiveRecord::Migration
  def change
    remove_column :listings, :title
    add_column :listings, :floor_area, :integer
  end
end
