# User
# A user is the main model for accounts on the site. It stores the
# email and handles password authentication. Users are allowed to have
# characters, which is where we pull in information to display about
# them.
#
class User < ActiveRecord::Base
  include Toggleable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # If a user has a rank they MUST be in the guild. Users without
  # a rank are assumed to be not invited yet.
  belongs_to :rank

  # Allowed to have many characters.
  has_many :characters, dependent: :delete_all

  # Has a main character.
  has_one :main, -> { where main: true }, class_name: 'Character'

  # Users make posts.
  has_many :posts, dependent: :destroy

  # A user can create an application, and will be urged
  # to if they do not have a rank.
  has_one :application, dependent: :destroy

  # Add an attachment for a user uploaded avatar.
  belongs_to :avatar, class_name: 'Upload'

  # A user can upload things. :)
  has_many :uploads

  # Users can shout very loudly! Or softly (oxymoron?).
  has_many :shouts

  # A user **must** have an email address, and a main character.
  validates :email, presence: true
  validates :main, presence: true

  # Set the number of users to show per page.
  paginates_per 20

  # Allow users forms to create mains and avatars.
  accepts_nested_attributes_for :main, :avatar

  # The name of this user is defined to be the name of their main.
  delegate :to_s, to: :main
end
