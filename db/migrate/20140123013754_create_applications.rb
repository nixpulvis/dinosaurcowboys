class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.belongs_to :user

      t.integer :state, default: 0

      t.string :name
      t.integer :age, null: false
      t.integer :gender, null: false
      t.string :battlenet, null: false

      t.text :logs
      t.text :computer, null: false
      t.text :raiding_history, null: false
      t.text :guild_history, null: false
      t.text :leadership, null: false
      t.text :playstyle, null: false
      t.text :why, null: false
      t.text :referer, null: false
      t.text :animal, null: false
      t.text :additional

      t.timestamps
    end
  end
end
