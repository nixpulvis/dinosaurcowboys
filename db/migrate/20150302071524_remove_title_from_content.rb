class RemoveTitleFromContent < ActiveRecord::Migration
  def change
    remove_column :contents, :title
  end
end
