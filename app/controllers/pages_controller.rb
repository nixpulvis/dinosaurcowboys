class PagesController < ApplicationController
  def home
    authorize self
  end

  def charter
    authorize self
  end

  def logs
    authorize self
  end

  def recruitment
    authorize self
  end
end
