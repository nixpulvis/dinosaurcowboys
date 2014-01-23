class AddStateToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :state, :integer, default: 0
  end
end
