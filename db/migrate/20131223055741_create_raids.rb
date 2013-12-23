class CreateRaids < ActiveRecord::Migration
  def change
    create_table :raids do |t|
      t.string :name
      t.integer :tier

      t.timestamps
    end
  end
end
