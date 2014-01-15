class Post < ActiveRecord::Base
  include PartyShark::Markdownable

  belongs_to :postable, :polymorphic => true
  belongs_to :user

  validates :body, :presence => true

  paginates_per 10
end
