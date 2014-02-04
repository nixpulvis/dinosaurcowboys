# PagesControllerPolicy
# Defines the policy for model-less pages on this site.
#
# The public can view all pages.
#
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
