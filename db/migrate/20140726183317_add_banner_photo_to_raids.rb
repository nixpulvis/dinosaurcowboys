class AddBannerPhotoToRaids < ActiveRecord::Migration
  def change
    add_column :raids, :banner_photo_file_name, :string
    add_column :raids, :banner_photo_content_type, :string
    add_column :raids, :banner_photo_file_size, :integer
    add_column :raids, :banner_photo_updated_at, :datetime
  end
end
