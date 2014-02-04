# PagesController
# Controller for the pages not backed by a distinct model.
#
# Actions: [home, charter, logs, recruitment]
#
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
