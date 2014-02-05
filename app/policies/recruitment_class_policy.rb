# RecruitmentClassPolicy
# Defines the policy for recruitment classes on this site.
#
class RecruitmentClassPolicy < BasePolicy
  class Scope < BaseScope  # rubocop:disable Documentation
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    user.rank.try(:>=, 'Officer') || super
  end

  def permitted_attributes
    [:class_name, :spec, :desire]
  end
end
