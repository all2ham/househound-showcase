class AddStiToRooms < ActiveRecord::Migration
  def change
    drop_table :room_types, {}
    drop_table :room_fields, {}
    add_column :rooms, :type, :string
    remove_column :rooms, :room_type_id
  end
end
