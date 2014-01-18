class PostsController < ApplicationController
  load_and_authorize_resource

  def create
    @post = postable.posts.build(post_params)
    @post.user = current_user

    if @post.save
      redirect_to postable_path(@post.postable)
    else
      render :new
    end
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to postable_path(@post.postable)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to postable_path(@post.postable)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def postable
    id, resource = request.path.split('/').reverse[1,2]
    resource.singularize.classify.constantize.find(id)
  end

  def postable_path(postable)
    if postable.is_a? Raid
      raid_path(postable)
    elsif postable.is_a? Boss
      raid_boss_path(postable.raid, postable)
    elsif postable.is_a? Topic
      forum_topic_path(postable.forum, postable)
    end
  end

end
