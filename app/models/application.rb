# Application
# An application is what a user will fill out to provide us
# with enough information to decide if they should have a trial
# or not.
#
class Application < ActiveRecord::Base
  include Postable
  include Markdownable
  include Toggleable

  # STATES = [
  #   :pending,
  #   :trial,
  #   :accepted,
  #   :rejected
  # ]
  enum status: [
    :pending,
    :trial,
    :accepted,
    :rejected
  ]

  # The person applying.
  belongs_to :user

  # Validate the fields of the application.
  validates :status, presence: true
  validates :name, length: { minimum: 3 },
                   format: { with: /[0-9a-z ]/i,
                             message: 'only allows alphanumeric characters' },
                   allow_blank: true
  validates :age, presence: true,
                  numericality: { only_integer: true }
  validates :gender, presence: true,
                     inclusion: { in: [0, 1] }

  # TODO: Add validation to the format of this field.
  validates :battlenet, presence: true

  # TODO: Add validation to the format of this URL.
  # validates :logs, format: { with: URI::regexp(["http", "https", ""]),
  #                            message: "is not a valid URL" },
  #                  allow_blank: true
  validates :computer, presence: true
  validates :raiding_history, presence: true
  validates :guild_history, presence: true
  validates :leadership, presence: true
  validates :playstyle, presence: true
  validates :why, presence: true
  validates :referer, presence: true
  validates :animal, presence: true

  # Set the number of applications to show per page.
  paginates_per 15

  # Send a creation email.
  after_create :send_email

  # -> ActiveRecord::Relation
  # Returns a relation of applications that are pending.
  #
  def self.pendings
    Application
      .where(hidden: false)
      .where(status: statuses[:pending])
  end

  # -> ActiveRecord::Relation
  # Returns a relation of applications that are trial.
  #
  def self.trials
    Application
      .where(hidden: false)
      .where(status: statuses[:trial])
  end

  # -> ActiveRecord::Relation
  # Returns a relation of applications that are accepted.
  #
  def self.accepteds
    Application
      .where(hidden: false)
      .where(status: statuses[:accepted])
  end

  # -> ActiveRecord::Relation
  # Returns a relation of applications that are rejected.
  #
  def self.rejecteds
    Application
      .where(hidden: false)
      .where(status: statuses[:rejected])
  end

  # -> String
  # A displayable format for the application.
  #
  def to_s
    "#{user}'s Application"
  end

  # Symbol -> Boolean
  # Sets the status of this application, changes ranks of the user
  # and sends emails.
  #
  def assign_status(value)
    case value.to_sym
    when :pending
      update_attribute(:status, value)
      user.update_attribute(:rank, nil)
    when :trial
      update_attribute(:status, value)
      user.update_attribute(:rank, Rank.find_by_name('Trial'))
    when :accepted
      update_attribute(:status, value)
      user.update_attribute(:rank, Rank.find_by_name('Raider'))
    when :rejected
      update_attribute(:status, value)
      user.update_attribute(:rank, nil)
    end

    send_email unless user.rank && value.to_sym == :rejected
  end

  def send_email
    ApplicationMailer.send("#{status}_email", self).deliver
  end
end
