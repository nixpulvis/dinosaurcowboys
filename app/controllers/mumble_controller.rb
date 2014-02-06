# MumbleController
# Controller for mumble json data.
#
# Actions: [index]
#
class MumbleController < ApplicationController

  # GET /mumble
  # Returns json data for our mumble server status.
  #
  def index
    mumble = PartyShark::Mumble.new(PartyShark::Mumble::SERVER, PartyShark::Mumble::PORT)
    authorize mumble

    respond_to do |format|
      format.json { render json: policy_scope(mumble) }
    end
  end

end
