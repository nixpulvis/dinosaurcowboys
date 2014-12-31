# ContentsController
# Controller for contents on the website.
#
# Actions: [new, create, edit, update, destroy]
#
class ContentsController < ApplicationController
  before_action only: [:edit, :update] do
    @content = Content.find(params[:id])
    authorize @content
  end

  # GET /contents/new
  # Build a new content to create.
  #
  def new
    @content = Content.new
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

  # GET /contents/:id/edit
  # Provides the given content to be updated.
  #
  def edit
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
