class AddUpdateToBosses < ActiveRecord::Migration
  def change
    add_column :bosses, :updates, :text

    Boss.reset_column_information
    Boss.all.each do |boss|
      boss.update_attribute(:updates, "")
    end
  end
end
