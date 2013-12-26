class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.belongs_to :postable, :polymorphic => true
      t.belongs_to :user

      t.timestamps
    end
  end
end
