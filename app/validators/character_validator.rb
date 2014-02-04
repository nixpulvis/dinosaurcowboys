# CharacterValidator
# Depends on :server and :name to be present.
#
class CharacterValidator < ActiveModel::Validator
  def validate(record)
    record.api
  rescue StandardError => e
    case e.message
    when /Realm/i
      record.errors.add(:server, 'is not a valid realm name')
    when /Character/i
      record.errors.add(:name, 'not found on Battle.net')
    else
      record.errors.add(:server, 'error with Blizzard API')
      record.errors.add(:name, 'error with Blizzard API')
    end
  end
end
