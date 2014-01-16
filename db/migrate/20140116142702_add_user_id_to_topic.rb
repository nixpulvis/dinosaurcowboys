class AddUserIdToTopic < ActiveRecord::Migration
  def change
    add_reference :topics, :user
  end
end
