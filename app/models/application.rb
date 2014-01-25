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

  # Validate the fields of the application.
  validates :state, presence: true
  validates :name, length: { minimum: 3 },
                   format: { with: /[0-9a-z ]/i,
                             message: "only allows alphanumeric characters" },
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

  # status -> String
  # Return the current status of the application.
  #
  def status
    self.id_changed? ? :created : STATES[self.state]
  end

  # status= Symbol -> Boolean
  # Sets the status of this application, changes ranks of the user
  # and sends emails.
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
    self.send_email
  end

  def send_email
    ApplicationMailer.send("#{self.status}_email", self).deliver
  end
end
