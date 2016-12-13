class AddTypeToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :room_type, index: true
  end
end
