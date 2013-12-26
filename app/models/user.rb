class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :characters, dependent: :destroy
  belongs_to :rank

  def main_character
    self.characters.select { |c| c.main? }[0]
  end
end
