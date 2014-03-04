class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.attachment :file
      t.references :uploadable, polymorphic: true

      t.timestamps
    end

    User.all.each do |user|
      if user.avatar_file_name
        upload = user.build_avatar

        upload.file_file_name    = user.avatar_file_name
        upload.file_content_type = user.avatar_content_type
        upload.file_file_size    = user.avatar_file_size
        upload.file_updated_at   = user.avatar_updated_at
        upload.save
      end
    end

    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
  end
end
