# Application
# An application is what a user will fill out to provide us
# with enough information to decide if they should have a trial
# or not.
#
class Application < ActiveRecord::Base
  STATES = [
    :pending,
    :trial,
    :accepted,
    :rejected,
  ]

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

  # status -> String
  # Return the current status of the application.
  #
  def status
    STATES[self.state]
  end

  # status= Symbol -> Boolean
  # Sets the status of this application, changes ranks of the user
  # and sends emails.
  #
  # TODO: Email sending.
  #
  def status=(value)
    case value.to_sym
    when :pending
      self.update_attribute(:state, 0)
      self.user.update_attribute(:rank, nil)
    when :trial
      self.update_attribute(:state, 1)
      self.user.update_attribute(:rank, Rank.find_by_name("Trial"))
    when :accepted
      self.update_attribute(:state, 2)
      self.user.update_attribute(:rank, Rank.find_by_name("Raider"))
    when :rejected
      self.update_attribute(:state, 3)
      self.user.update_attribute(:rank, nil)
    end
  end
end
