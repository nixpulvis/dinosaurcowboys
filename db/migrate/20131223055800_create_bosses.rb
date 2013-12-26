class CreateBosses < ActiveRecord::Migration
  def change
    create_table :bosses do |t|
      t.string :name
      t.text :content
      t.belongs_to :raid

      t.timestamps
    end
  end
end
