# UploadPolicy
# Defines the policy for uploading things to the site.
#
# Uploads are all public, in that there is no notion of
# viewing restriction on them.
#
class UploadPolicy < BasePolicy
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
    (user == record.user && user.rank)# || super
  end

  def update?
    user == record.user || super
  end

  def destroy?
    user == record.user || super
  end

  def permitted_attributes
    [:file]
  end
end
