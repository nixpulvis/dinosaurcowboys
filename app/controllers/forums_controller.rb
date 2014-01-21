class ForumsController < ApplicationController
  load_and_authorize_resource

  # GET /forums
  # Provide all the forums and the recent topics.
  #
  def index
    @topics = Topic.accessible_by(current_ability).page(params[:page])
  end

  # GET /forums/new
  # Build a new forum to create.
  #
  def new
  end

  # POST /forums
  # Create a new forum with the passed in parameters.
  #
  def create
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
    @topics = @forum.topics.page(params[:page])

    # Creating new topics.
    @topic = @forum.topics.build
    @topic.posts.build
  end

  # GET /forums/:id/edit
  # Provide the forum to edit.
  #
  def edit
    # TODO: Create view.
  end

  # PATCH or PUT /forums/:id
  # Allows for updates to the forum.
  #
  def update
    # TODO: Write action.
  end

  # DELETE /forums/:id
  # Destroy the forum and all of it's topics/posts.
  #
  def destroy
    # TODO: Write action.
  end

  private

  def forum_params
    params.require(:forum).permit(:name)
  end

end
