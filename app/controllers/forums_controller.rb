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
    _topics = policy_scope(Topic)
                .includes(:posts)
                .order('posts.created_at DESC')

    # TODO: Look into doing this with sql, this is going to be
    # very slow when there are a lot of topics.
    @topics = Kaminari.paginate_array(_topics.to_a)
                      .page(params[:page])
                      .per(10)

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
    _topics = policy_scope(@forum.topics)
                .includes(:posts)
                .order('sticky DESC, posts.created_at DESC')

    # TODO: Look into doing this with sql, this is going to be
    # very slow when there are a lot of topics.
    @topics = Kaminari.paginate_array(_topics.to_a)
                      .page(params[:page])
                      .per(Topic.default_per_page)

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
