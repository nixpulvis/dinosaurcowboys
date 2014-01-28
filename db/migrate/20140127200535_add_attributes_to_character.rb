class AddAttributesToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :achievement_points, :integer
    add_column :characters, :average_item_level_equiped, :integer
    add_column :characters, :spec, :string
    add_column :characters, :role, :string
    add_column :characters, :thumbnail, :string
    add_column :characters, :guild_name, :string
  end
end
