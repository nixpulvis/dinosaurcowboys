class Post < ActiveRecord::Base
  include PartyShark::Markdownable

  belongs_to :postable, :polymorphic => true
  belongs_to :user
end
