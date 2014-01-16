class Post < ActiveRecord::Base
  include PartyShark::Markdownable

  default_scope order('created_at ASC')

  belongs_to :postable, :polymorphic => true
  belongs_to :user

  validates :body, :presence => true

  paginates_per 10
end
