# PagesController
# Controller for the pages not backed by a distinct model.
#
# Actions: [home, charter, logs, recruitment]
#
class PagesController < ApplicationController
  def home
    authorize self

    @mumble = PartyShark::Mumble.new("partyshark.typefrag.com", 7675)
  end

  def charter
    authorize self
  end

  def logs
    authorize self
  end
end
