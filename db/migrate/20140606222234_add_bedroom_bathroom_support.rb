class AddBedroomBathroomSupport < ActiveRecord::Migration
  def change
    create_table :bedrooms do |t|
      t.belongs_to :listing
      t.string :context
      t.float :square_footage

      t.timestamps
    end

    create_table :bathrooms do |t|
      t.belongs_to :listing
      t.string :context
      t.float :square_footage

      t.timestamps
    end
    add_index :bedrooms, :listing_id
    add_index :bathrooms, :listing_id
  end
end
