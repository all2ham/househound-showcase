class AddUniqueIndexUserListingToFollows < ActiveRecord::Migration
  def change
    remove_index :follows, :user_id
    add_index :follows, [:user_id, :listing_id]
  end
end
