class AddTimeToOpenHouses < ActiveRecord::Migration
  def change
    add_column :open_houses, :start_time, :time
    add_column :open_houses, :end_time, :time
  end
end
