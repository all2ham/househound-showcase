class CreateOpenHouses < ActiveRecord::Migration
  def change
    create_table :open_houses do |t|
      t.datetime :date
      t.belongs_to :listing, index: true

      t.timestamps
    end
  end
end
