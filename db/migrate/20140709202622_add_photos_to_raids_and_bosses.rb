class AddPhotosToRaidsAndBosses < ActiveRecord::Migration
  def change
    add_column :raids, :banner_photo_id, :integer
  end
end
