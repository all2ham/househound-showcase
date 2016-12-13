class RenameListingUidToSlug < ActiveRecord::Migration
  def change
    remove_index :listings, column: :uid
    rename_column :listings, :uid, :slug
    add_index :listings, :slug, unique: true
  end
end
