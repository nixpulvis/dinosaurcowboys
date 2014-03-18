class CreateUploads < ActiveRecord::Migration
  def up
    create_table :uploads do |t|
      t.attachment :file
      t.belongs_to :user

      t.timestamps
    end

    add_reference :users, :avatar

    User.all.each do |user|
      if user.avatar_file_name
        upload = user.uploads.build

        upload.file_file_name    = user.avatar_file_name
        upload.file_content_type = user.avatar_content_type
        upload.file_file_size    = user.avatar_file_size
        upload.file_updated_at   = user.avatar_updated_at
        upload.save

        user.avatar = upload
        user.save
      end
    end

    remove_column :users, :avatar_file_name, :string
    remove_column :users, :avatar_content_type, :string
    remove_column :users, :avatar_file_size, :integer
    remove_column :users, :avatar_updated_at, :datetime
  end

  def down
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_updated_at, :datetime

    User.all.each do |user|
      if user.avatar
        avatar = user.avatar

        user.avatar_file_name    = avatar.file_file_name
        user.avatar_content_type = avatar.file_content_type
        user.avatar_file_size    = avatar.file_file_size
        user.avatar_updated_at   = avatar.file_updated_at
        user.save
      end
    end

    drop_table :uploads
    remove_reference :users, :avatar
  end
end
