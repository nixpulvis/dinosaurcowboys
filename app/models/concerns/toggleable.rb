# Toggleable
# Methods to add to models with a hidden attribute. Allows for
# toggling the model to be shown or not.
#
module Toggleable
  extend ActiveSupport::Concern

  def toggle
    hidden ? show : hide
  end

  def hide
    self.hidden = true
    save
  end

  def show
    self.hidden = false
    save
  end

  def shown?
    !hidden?
  end
end
