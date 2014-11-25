class CreateShouts < ActiveRecord::Migration
  def up
    create_table :shouts do |t|
      t.string      :shout,   null: false
      t.boolean     :hidden,  default: false
      t.belongs_to  :user

      t.timestamps
    end
  end

  def down
    drop_table :shouts
  end
end
