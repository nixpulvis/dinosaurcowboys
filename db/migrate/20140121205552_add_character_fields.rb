class AddCharacterFields < ActiveRecord::Migration
  def change
    add_column :characters, :klass, :string
    add_column :characters, :level, :integer
  end
end
