# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  imageable_id       :integer
#  imageable_type     :string(255)
#  photo              :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Photo < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true

  mount_uploader :photo, PhotoUploader

  # validates_attachment_presence :image
  #
  # validates_attachment_size :image, :less_than => 3.megabytes
  # validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

  # before_image_post_process :check_file_size

  def check_file_size
    valid?
    errors[:image_file_size].blank?
  end
end
