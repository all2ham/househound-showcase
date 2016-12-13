class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.belongs_to :listing, index: true

      t.timestamps
    end
    add_column :rooms, :properties, :hstore
    add_index :rooms, :properties, using: :gin
  end
end
