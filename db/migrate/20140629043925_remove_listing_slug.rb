class RemoveListingSlug < ActiveRecord::Migration
  def change
    remove_column :listings, :slug, :string
  end
end
