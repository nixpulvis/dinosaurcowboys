# Application
# An application is what a user will fill out to provide us
# with enough information to decide if they should have a trial
# or not.
#
class Application < ActiveRecord::Base
  include Postable

  STATES = [
    :pending,
    :trial,
    :accepted,
    :rejected
  ]

  # The person applying.
  belongs_to :user

  # Validate the fields of the application.
  validates :state, presence: true
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

  # Send a creation email.
  after_create :send_email

  # Symbol -> Fixnum
  # Returns the state corresponding to the given status.
  #
  def self.state(status)
    Application::STATES.index(status)
  end

  # -> String
  # A displayable format for the application.
  #
  def to_s
    "#{user}'s Application"
  end

  # -> String
  # Return the current status of the application.
  #
  def status
    self.id_changed? ? :created : STATES[state]
  end

  # Symbol -> Boolean
  # Sets the status of this application, changes ranks of the user
  # and sends emails.
  #
  def status=(value)
    case value.to_sym
    when :pending
      update_attribute(:state, 0)
      user.update_attribute(:rank, nil)
    when :trial
      update_attribute(:state, 1)
      user.update_attribute(:rank, Rank.find_by_name('Trial'))
    when :accepted
      update_attribute(:state, 2)
      user.update_attribute(:rank, Rank.find_by_name('Raider'))
    when :rejected
      update_attribute(:state, 3)
      user.update_attribute(:rank, nil)
    end

    send_email unless user.rank && value.to_sym == :rejected
  end

  def send_email
    ApplicationMailer.send("#{status}_email", self).deliver
  end
end
