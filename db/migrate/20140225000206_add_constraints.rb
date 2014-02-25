class AddConstraints < ActiveRecord::Migration
  def change
    change_column_null :accesses, :permission, false
    change_column_null :accesses, :rank_id, false
    change_column_null :accesses, :forum_id, false
    change_column_null :applications, :user_id, false
    change_column_null :bosses, :raid_id, false
    change_column_null :bosses, :name, false
    change_column_null :characters, :main, false
    change_column_null :characters, :user_id, false
    change_column_null :features, :title, false
    change_column_null :features, :body, false
    change_column_null :posts, :body, false
    change_column_null :posts, :postable_id, false
    change_column_null :posts, :postable_type, false
    change_column_null :posts, :user_id, false
    change_column_null :raids, :name, false
    change_column_null :raids, :tier, false
    change_column_null :recruitment_classes, :class_name, false
    change_column_null :recruitment_classes, :desires, false
    change_column_null :topics, :user_id, false
    change_column_null :topics, :sticky, false
    change_column_null :users, :admin, false
  end
end
