class AddRaidModeratorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :raid_moderator, :boolean
  end
end
