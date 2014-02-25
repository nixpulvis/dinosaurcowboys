class AddIndices < ActiveRecord::Migration
  def change
    add_index :accesses, :rank_id
    add_index :accesses, :forum_id
    add_index :applications, :user_id
    add_index :bosses, :raid_id
    add_index :characters, :user_id
    add_index :posts, :user_id
    add_index :posts, :postable_id
    add_index :topics, :user_id
    add_index :topics, :forum_id
    add_index :users, :rank_id
  end
end
