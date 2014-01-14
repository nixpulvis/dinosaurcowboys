class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :characters, dependent: :destroy
  belongs_to :rank

  validates :email, :presence => true

  accepts_nested_attributes_for :characters

  def to_s
    self.main_character.to_s
  end

  def main_character
    self.characters.select { |c| c.main? }[0]
  end
end
