class FeaturesToContent < ActiveRecord::Migration
  def change
    rename_table :features, :contents
    add_column :contents, :label, :string

    Content.reset_column_information
    Content.all.each { |c| c.update_column(:label, :home_feature) }
  end
end
