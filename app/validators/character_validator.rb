# Depends on :server and :name to be present.
class CharacterValidator < ActiveModel::Validator
  def validate(record)
    begin
      record.api = WoW::CharacterProfile.new(record.server, record.name)
    rescue WoW::APIError => e
      case e.message
      when /Realm/
        record.errors.add(:server, "is not a valid realm name")
      when /Character/
        record.errors.add(:name, "not found on Battle.net")
      else
        record.errors.add(:server, "cannot validate due to error with Blizzard API")
        record.errors.add(:name, "cannot validate due to error with Blizzard API")
      end
    end
  end
end
