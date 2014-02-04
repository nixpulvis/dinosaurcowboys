# BasePolicy
# Sets up the default policies for the application. Mainly allowing
# admins full control.
#
# Subclasses of BasePolicy should always call `super` on their methods.
#
class BasePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user || User.new
    @record = record
  end

  class BaseScope  # rubocop:disable Documentation
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user || User.new
      @scope = scope
    end

    def resolve
      fail NotImplementedError, "Implement resolve in #{self.class}"
    end
  end

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    fail NotImplementedError, "Implement permitted_attributes in #{self.class}"
  end

  def allows?(attribute)
    permitted_attributes.include?(attribute)
  end
end
