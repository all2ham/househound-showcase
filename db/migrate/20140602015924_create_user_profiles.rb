class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :website
      t.string :brokerage
      t.belongs_to :user

      t.timestamps
    end
  end
end
