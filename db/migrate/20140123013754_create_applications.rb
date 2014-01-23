class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.belongs_to :user

      t.string :name
      t.integer :age
      t.integer :gender
      t.string :battlenet

      t.text :logs
      t.text :computer
      t.text :history
      t.text :leadership
      t.text :skill
      t.text :why

      t.timestamps
    end
  end
end
