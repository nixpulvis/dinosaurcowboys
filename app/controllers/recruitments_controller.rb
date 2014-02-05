# RecruitmentController
# Controller for the RecruitmentClass model.
#
# Actions: [show, edit, update]
#
class RecruitmentsController < ApplicationController

  def show
    @recruitments = policy_scope(RecruitmentClass)
    authorize @recruitments
  end

  def edit
    @recruitments = policy_scope(RecruitmentClass)
    authorize RecruitmentClass
  end

  def update
    authorize RecruitmentClass

    params[:recruitment_class].each do |id, desires|
      RecruitmentClass.find(id).update_attributes(desires: desires)
    end

    redirect_to recruitment_path
  end



end
