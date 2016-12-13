class CreateAccessCodes < ActiveRecord::Migration
  def change
    create_table :access_codes do |t|
      t.string :code, index: true
      t.integer :limit
      t.text :notes
      t.timestamps null: false
    end

    add_reference :users, :access_code
  end
end
