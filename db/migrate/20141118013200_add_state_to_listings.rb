class AddStateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :step, :string
    add_column :listings, :active, :boolean, default: false, null: false
  end
end
