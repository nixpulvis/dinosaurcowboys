class FeaturesToContent < ActiveRecord::Migration
  def change
    rename_table :features, :contents
    add_column :contents, :label, :string

    Content.reset_column_information
    Content.order(created_at: :desc).first.update_column(:label, :home_feature)
    Content.where(label: nil).destroy_all
  end
end
