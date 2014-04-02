# FeaturePolicy
# Defines the policy for viewing and making features.
#
# Everyone can see features, and Officers and higher can create them.
#
class FeaturePolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.rank.try(:>=, 'Officer') || super
  end

  def update?
    create?
  end

  def permitted_attributes
    [:title, :body]
  end
end
