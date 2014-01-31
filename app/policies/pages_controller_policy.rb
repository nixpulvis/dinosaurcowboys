class PagesControllerPolicy < BasePolicy
  def home?
    true
  end

  def charter?
    true
  end

  def logs?
    true
  end

  def recruitment?
    true
  end
end
