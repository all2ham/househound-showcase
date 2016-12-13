class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :message
      t.references :notifiable, polymorphic: true, index: true
      t.datetime :deleted_at, index: true

      t.timestamps null: false
    end
  end
end
