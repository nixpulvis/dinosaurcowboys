class AddHidableToModels < ActiveRecord::Migration
  def change
    add_column :users, :hidden, :boolean, default: false
    add_column :applications, :hidden, :boolean, default: false
    add_column :raids, :hidden, :boolean, default: false
    add_column :bosses, :hidden, :boolean, default: false
  end
end
