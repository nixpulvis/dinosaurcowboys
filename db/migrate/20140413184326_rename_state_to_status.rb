class RenameStateToStatus < ActiveRecord::Migration
  def change
    rename_column :applications, :state, :status
  end
end
