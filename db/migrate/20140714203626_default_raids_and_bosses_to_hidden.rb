class DefaultRaidsAndBossesToHidden < ActiveRecord::Migration
  def change
    change_column :raids, :hidden, :boolean, default: true
    change_column :bosses, :hidden, :boolean, default: true
  end
end
