class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.string :permission
      t.belongs_to :rank
      t.belongs_to :forum
      t.timestamps
    end
  end
end
