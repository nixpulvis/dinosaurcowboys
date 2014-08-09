class AddStickyToBosses < ActiveRecord::Migration
  def change
    add_column :bosses, :sticky, :boolean, default: false
  end
end
