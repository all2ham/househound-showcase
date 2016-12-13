class CreateRoomFields < ActiveRecord::Migration
  def change
    create_table :room_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :room_type, index: true

      t.timestamps
    end
  end
end
