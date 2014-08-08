class AddOrderToBosses < ActiveRecord::Migration
  def change
    add_column :bosses, :row_order, :integer, unique: true, null: false, default: 0
  end
end
