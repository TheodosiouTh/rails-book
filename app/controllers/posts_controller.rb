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
    @likes = Like.where(user_id: current_user.id)

    @comment = Comment.new
    @like = Like.new
  end

  def my_comment
    @post = Post.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to @post
  end

  def my_like
    @post = Post.find(params[:id])
    if !params[:like].nil? && !params[:like][:comment_id].nil?
      #like comment
      @like = Like.new(user_id: current_user.id, comment_id: params[:like][:comment_id])
      @like.save
    else
      # like post
      @like = Like.new(user_id: current_user.id, post_id: params[:id])
      @like.save
    end
    redirect_to @post
  end

private
  def post_params
    params[:post][:creator_id] = current_user.id
    params.require(:post).permit(:title, :content, :creator_id )
  end
  
  def comment_params
    params[:comment][:creator_id] = current_user.id
    params[:comment][:post_id] = params[:id]
    params.require(:comment).permit(:content, :post_id ,:creator_id )
  end
end
