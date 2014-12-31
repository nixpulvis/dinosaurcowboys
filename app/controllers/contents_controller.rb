# ContentsController
# Controller for contents on the website.
#
# Actions: [new, create, edit, update, destroy]
#
class ContentsController < ApplicationController
  before_action only: :update do
    @content = Content.find(params[:id])
    authorize @content
  end

  # POST /contents
  # Create a new content with the passed in parameters.
  # Redisplays the new page when there are errors.
  #
  def create
    @content = Content.new(content_params)
    authorize @content
    @content.save
    redirect_to :back
  end

  # PATCH or PUT /contents/:id
  # Allows the content to be updated.
  #
  def update
    @content.update_attributes(content_params)
    redirect_to :back
  end

  protected

  # content_params: -> Hash
  # Permits the content fields for the assignment.
  #
  def content_params
    params.require(:content).permit(*policy(@content || Content)
                            .permitted_attributes)
  end
end
