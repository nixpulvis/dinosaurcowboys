class PostsController < ApplicationController

  def create
    @post = postable.posts.build(post_params)
    @post.user = current_user

    if @post.save
      redirect_to :back
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def postable
    id, resource = request.path.split('/').reverse[1,2]
    resource.singularize.classify.constantize.find(id)
  end

end
