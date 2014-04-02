# RecruitmentController
# Controller for the RecruitmentClass model.
#
# Actions: [show, edit, update]
#
class RecruitmentsController < ApplicationController
  # GET /recruitment
  # Provides the recruitment class needs.
  #
  def show
    @recruitments = policy_scope(RecruitmentClass).all
    authorize @recruitments
  end

  # GET /recruitment/edit
  # Provides the recruitment class needs for editing.
  #
  def edit
    @recruitments = policy_scope(RecruitmentClass).all
    authorize RecruitmentClass
  end

  # PATCH or PUT /recruitment
  # Updates each of the recruitment classes in the params
  # with their corresponding new values.
  #
  def update
    authorize RecruitmentClass

    params[:recruitment_class].each do |id, desires|
      RecruitmentClass.find(id).update_attributes(desires: desires)
    end

    redirect_to recruitment_path
  end
end
