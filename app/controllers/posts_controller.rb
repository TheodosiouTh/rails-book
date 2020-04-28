class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if !params[:post][:image].nil?
        @post.image.attach(params[:post][:image])
      end
      redirect_to @post
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @creator = User.find(@post.creator_id)
  end

private
  def post_params
    params[:post][:creator_id] = current_user.id
    params.require(:post).permit(:title, :content, :creator_id )
  end
end
