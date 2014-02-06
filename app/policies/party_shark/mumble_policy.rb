# MumblePolicy
# Defines the policy for mumble status access on this site.
#
class PartyShark::MumblePolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope.data
    end
  end

  def index?
    user.rank || super
  end
end
