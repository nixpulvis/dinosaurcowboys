class AddOrderToForums < ActiveRecord::Migration
  def up
    add_column :forums, :row_order, :integer, unique: true
    Forum.reset_column_information
    Forum.order(created_at: :asc).each_with_index do |forum, index|
      forum.update_attribute(:row_order, index)
    end
    change_column :forums, :row_order, :integer, unique: true, null: false, default: 0
  end

  def down
    remove_column :forums, :row_order
  end
end
