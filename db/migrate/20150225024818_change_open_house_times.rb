class ChangeOpenHouseTimes < ActiveRecord::Migration
  def change
    remove_column :open_houses, :start_time
    remove_column :open_houses, :end_time

    add_column :open_houses, :start, :datetime
    add_column :open_houses, :end, :datetime
  end
end
