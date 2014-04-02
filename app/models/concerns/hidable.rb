# Hidable
#
module Hidable
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
