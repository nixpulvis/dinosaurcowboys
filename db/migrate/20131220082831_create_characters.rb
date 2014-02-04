class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :server, null: false
      t.boolean :main?, default: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
