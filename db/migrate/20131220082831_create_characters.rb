class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :server
      t.boolean :main?
      t.belongs_to :user
      t.timestamps
    end
  end
end
