# ContentPolicy
# Defines the policy for viewing and making features.
#
# Everyone can see features, and Officers and higher can create them.
#
class ContentPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope
    end
  end

  def create?
    user.rank.try(:>=, 'Officer') || super
  end

  def update?
    create?
  end

  def permitted_attributes
    [:label, :title, :body]
  end
end
