class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.float :price
      t.text :description
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :province
      t.string :country

      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
