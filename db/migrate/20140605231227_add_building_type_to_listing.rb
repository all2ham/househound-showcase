class AddBuildingTypeToListing < ActiveRecord::Migration
  def change
    add_column :listings, :building_type, :integer
    add_column :listings, :building_style, :integer
    add_column :listings, :property_taxes, :float
  end
end
