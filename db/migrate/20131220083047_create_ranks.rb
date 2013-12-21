class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name
      t.belongs_to :user
      t.timestamps
    end
  end
end
