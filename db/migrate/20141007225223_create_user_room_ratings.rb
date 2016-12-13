class CreateUserRoomRatings < ActiveRecord::Migration
  def change
    create_table :user_room_ratings do |t|
      t.integer :score
      t.references :user, index: true
      t.references :room, index: true

      t.timestamps
    end
  end
end
