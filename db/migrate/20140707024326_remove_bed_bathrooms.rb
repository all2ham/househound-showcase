class RemoveBedBathrooms < ActiveRecord::Migration
  def change
    drop_table :bedrooms, {}
    drop_table :bathrooms, {}
  end
end
