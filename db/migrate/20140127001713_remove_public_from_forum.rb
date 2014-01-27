class RemovePublicFromForum < ActiveRecord::Migration
  def change
    remove_column :forums, :public
  end
end
