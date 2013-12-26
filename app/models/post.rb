class Post < ActiveRecord::Base
  belongs_to :postable, :polymorphic => true
  belongs_to :user
end
