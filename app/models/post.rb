class Post < ActiveRecord::Base
  include PartyShark::Markdownable

  belongs_to :postable, :polymorphic => true, :touch => true
  belongs_to :user

  validates :body, :presence => true

  default_scope -> { order('created_at ASC') }

  paginates_per 10
end
