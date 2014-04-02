# Hidable
#
module Hidable
  extend ActiveSupport::Concern

  def toggle
    if hidden
      show
    else
      hide
    end
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
