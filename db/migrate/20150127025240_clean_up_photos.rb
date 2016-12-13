class CleanUpPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :image_file_name, :photo
  end
end
