class Post < ActiveRecord::Base
  include PartyShark::Markdownable

  paginates_per 10

  belongs_to :postable, :polymorphic => true
  belongs_to :user
end
