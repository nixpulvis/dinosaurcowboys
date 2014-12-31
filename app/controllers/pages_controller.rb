# PagesController
# Controller for the pages not backed by a distinct model.
#
# Actions: [home, charter, logs, recruitment]
#
class PagesController < ApplicationController
  def home
    authorize self

    @content = Content.for(:home_feature)
  end

  def charter
    authorize self

    @content = Content.for(:charter)
  end

  def logs
    authorize self
  end
end
