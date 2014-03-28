# Hidable
#
module Hidable
  extend ActiveSupport::Concern

  def toggle
    if self.hidden
      self.show
    else
      self.hide
    end
  end

  def hide
    self.hidden = true
    self.save
  end

  def show
    self.hidden = false
    self.save
  end

  def shown?
    !self.hidden?
  end
end
