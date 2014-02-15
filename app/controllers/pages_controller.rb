# PagesController
# Controller for the pages not backed by a distinct model.
#
# Actions: [home, charter, logs, recruitment]
#
class PagesController < ApplicationController
  def home
    authorize self

    @feature = Feature.order(created_at: :desc).first
  end

  def charter
    authorize self
  end

  def logs
    authorize self
  end
end
