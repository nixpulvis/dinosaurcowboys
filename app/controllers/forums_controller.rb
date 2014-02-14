# ForumsController
# Controller for the Forum model.
#
# Actions: [index, new, create, show, edit, update, destroy]
#
class ForumsController < ApplicationController
  before_filter only: [:show, :edit, :update, :destroy] do
    @forum = Forum.find(params[:id])
    authorize @forum
  end

  # GET /forums
  # Provide all the forums and the recent topics.
  #
  def index
    @forums = policy_scope(Forum)
    @topics = policy_scope(Topic)
                .order(updated_at: :desc)
                .page(params[:page])
    authorize @forums
  end

  # GET /forums/new
  # Build a new forum to create.
  #
  def new
    @forum = Forum.new
    authorize @forum
  end

  # POST /forums
  # Create a new forum with the passed in parameters.
  #
  def create
    @forum = Forum.new(forum_params)
    authorize @forum

    if @forum.save
      redirect_to forum_path(@forum)
    else
      render :new
    end
  end

  # GET /forums/:id
  # Show the forum, with it's topics, and a form to
  # create new topics.
  #
  def show
    @topics = policy_scope(@forum.topics)
                .order(sticky: :desc, updated_at: :desc)
                .page(params[:page])

    # Creating new topics.
    @topic = @forum.topics.build
    @topic.posts.build
  end

  # GET /forums/:id/edit
  # Provide the forum to edit.
  #
  def edit
  end

  # PATCH or PUT /forums/:id
  # Allows for updates to the forum.
  #
  def update
    if @forum.update_attributes(forum_params)
      redirect_to forum_path(@forum)
    else
      render :edit
    end
  end

  # DELETE /forums/:id
  # Destroy the forum and all of it's topics/posts.
  #
  def destroy
    @forum.destroy
    redirect_to forums_path
  end

  private

  # forum_params: -> Hash
  # Permits the forum fields for assignment.
  #
  def forum_params
    permit = policy(@forum || Forum).permitted_attributes
    params.require(:forum).permit(*permit)
  end
end
