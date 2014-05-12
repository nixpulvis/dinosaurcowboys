# RecruitmentClass
# Represents the needs of a specific class to our guild. Each spec
# will have a number representing the desirability of that spec.
#
class RecruitmentClass < ActiveRecord::Base
  DEFAULTS = {
    'Death Knight' => %w(Blood Frost Unholy),
    'Druid'        => %w(Balance Feral Guardian Restoration),
    'Hunter'       => %w(Beast\ Mastery Marksmanship Survival),
    'Mage'         => %w(Arcane Fire Frost),
    'Monk'         => %w(Brewmaster Mistweaver Windwalker),
    'Paladin'      => %w(Holy Protection Retribution),
    'Priest'       => %w(Discipline Holy Shadow),
    'Rogue'        => %w(Assassination Combat Subtlety),
    'Shaman'       => %w(Elemental Enhancement Restoration),
    'Warlock'      => %w(Affliction Demonology Destruction),
    'Warrior'      => %w(Arms Fury Protection)
  }

  # Save the desires hash as text in the database.
  serialize :desires, Hash

  # They must have a class_name.
  validates :class_name, presence: true

  # -> DateTime
  # Returns the datetime of the last updated recruitment class.
  #
  def self.updated_at
    maximum(:updated_at)
  end

  # Look up desires as methods.
  # For example: `RecruitmentClass.first.Balance`
  def method_missing(name, *args)
    key = name.to_s
    if desires.key?(key)
      desires[key]
    else
      super
    end
  end

  # Always redefine this when overloading `method_missing`
  def respond_to?(name, include_private = false)
    desires.key?(name.to_s) || super
  end

  # The way rails does this by default falls back on `method_missing`,
  # we must define it explicitly because we use it in `method_missing`.
  def desires
    self[:desires]
  end

  # -> Hash
  # Returns the same type of data as `desires` except with
  # only specs that are needed.
  #
  def needs
    desires.select { |_spec, value| value.present? }
  end

  # -> Boolean
  # Returns true when there are needed specs in this class.
  #
  def needed?
    needs.present?
  end

  # -> String
  # Returns the path to this classes icon.
  #
  def class_icon_path
    class_file = class_name.gsub(' ', '').underscore
    "class_#{class_file}.png"
  end

  # -> String
  # Returns the path to the icon of the given spec of this class.
  #
  def spec_icon_path(spec)
    class_file = class_name.gsub(' ', '').underscore
    spec_file  = spec.gsub(' ', '').underscore
    "class_#{class_file}/spec_#{spec_file}.jpg"
  end
end
