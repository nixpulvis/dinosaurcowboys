class ForumsController < ApplicationController

  # GET /forums
  # Provide all the forums and the recent topics.
  #
  def index
    @forums = policy_scope(Forum)
    @topics = policy_scope(Topic).page(params[:page])
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
    @forum = Forum.find(params[:id])
    @topics = policy_scope(@forum.topics).page(params[:page])
    authorize @forum

    # Creating new topics.
    @topic = @forum.topics.build
    @topic.posts.build
  end

  # GET /forums/:id/edit
  # Provide the forum to edit.
  #
  def edit
    @forum = Forum.find(params[:id])
    authorize @forum
  end

  # PATCH or PUT /forums/:id
  # Allows for updates to the forum.
  #
  def update
    @forum = Forum.find(params[:id])
    authorize @forum

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
    @forum = Forum.find(params[:id])
    authorize @forum

    @forum.destroy
    redirect_to forums_path
  end

  private

  def forum_params
    params.require(:forum).permit(*policy(@forum || Forum).permitted_attributes)
  end

end
