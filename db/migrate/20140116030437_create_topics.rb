class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.belongs_to :forum, null: false
      t.timestamps
    end
  end
end
