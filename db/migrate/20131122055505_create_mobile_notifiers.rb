class CreateMobileNotifiers < ActiveRecord::Migration
  def change
    create_table :mobile_notifiers do |t|
      t.string :uid
      t.belongs_to :user

      t.timestamps
    end
  end
end
