# RaidPolicy
# Defines the policy for raids on this site.
#
# The public is allowed to read the raids.
# Trials and higher are allowed to comment.
# Officers are allowed to create and update raids.
#
class RaidPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(hidden: false)
      end
    end
  end

  def index?
    true
  end

  def show?
    read? || super
  end

  def create?
    user.rank.try(:>=, 'Officer') || user.raid_moderator? || super
  end

  def update?
    create? || super
  end

  def destroy?
    false
  end

  # READ === See the topic, and its posts.
  def read?
    record.shown? || user.admin?
  end

  # WRITE === Make a new topic, and post on it.
  def write?
    user.rank.try(:>=, 'Trial')
  end

  def permitted_attributes
    [:name, :tier, :content]
  end
end
