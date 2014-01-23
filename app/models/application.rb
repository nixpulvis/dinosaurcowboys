# Application
# An application is what a user will fill out to provide us
# with enough information to decide if they should have a trial
# or not.
#
class Application < ActiveRecord::Base
  # The person applying.
  belongs_to :user

  # An application should have discussion.
  has_many :posts, as: :postable, dependent: :destroy

  # The application requires all of it's attributes.
  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :battlenet, presence: true
  validates :logs, presence: true
  validates :computer, presence: true
  validates :history, presence: true
  validates :leadership, presence: true
  validates :skill, presence: true
  validates :why, presence: true
end
