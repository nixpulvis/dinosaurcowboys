class AddPublicToForum < ActiveRecord::Migration
  def change
    add_column :forums, :public, :boolean, defalut: false
  end
end
