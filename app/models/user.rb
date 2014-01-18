class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :characters, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :rank

  validates :email, :presence => true

  accepts_nested_attributes_for :characters

  def to_s
    self.main.to_s
  end

  def main
    self.characters.where(main: true).first
  end
end
