class RenameCharacterMain < ActiveRecord::Migration
  def change
    rename_column :characters, :main?, :main
  end
end
