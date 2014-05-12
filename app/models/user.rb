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

  # Allowed to have many characters, but one **must** be the main.
  has_many :characters, dependent: :delete_all

  # Users make posts.
  has_many :posts, dependent: :destroy

  # A user can create an application, and will be urged
  # to if they do not have a rank.
  has_one :application, dependent: :destroy

  # Add an attachment for a user uploaded avatar.
  belongs_to :avatar, class_name: 'Upload'

  # A user can upload things. :)
  has_many :uploads

  # A user **must** have an email address, and a character.
  validates :email, presence: true
  validates :characters, presence: true

  # Set the number of users to show per page.
  paginates_per 20

  # Allow users forms to create characters.
  accepts_nested_attributes_for :characters, :avatar

  # The name of this user is defined to be the name of their main.
  delegate :to_s, to: :main

  # -> Character
  # The users main character.
  #
  def main
    characters.where(main: true).first
  end
end
