class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state_province
      t.string :zip_postcode
      t.string :country
      t.belongs_to :listing, index: true
      t.timestamps
    end

    remove_column :listings, :address, :string
    remove_column :listings, :city, :string
    remove_column :listings, :postal_code, :string
    remove_column :listings, :province, :string
    remove_column :listings, :country, :string
  end
end
