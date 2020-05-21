class PostsController < ApplicationController
  def index
    #get friends
    @friends = []

    incomming = current_user.incomming
    incomming.each do |rqst|
      if rqst.accepted
        @friends << User.find(rqst.from_id)
      end
    end

    outgoing = current_user.outgoing
    outgoing.each do |rqst|
      if rqst.accepted
        @friends << User.find(rqst.to_id)
      end
    end

    # get posts from friends
    @friends.each do |friend|
      if @posts.nil?
        @posts = friend.posts
      else
        @posts = @posts.or(friend.posts)
      end
    end
    
    #get newer posts first
    if !@posts.nil?
      @posts = @posts.order(created_at: :desc)
    end

    @likes = Like.where(user_id: current_user.id)

    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if !params[:post][:image].nil?
        res = Cloudinary::Uploader.upload(params[:post][:image])
        @post.update(post_pic: res["secure_url"]);
      end
      redirect_to root_url
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

  def my_action
    if !params[:comment].nil? && params[:comment][:content]!=""
      @post = Post.find(params[:comment][:post_id])
      @comment = Comment.new(comment_params)
      @comment.save
    elsif !params[:like].nil?
      @post = Post.find(params[:like][:post_id])
      if !params[:like][:comment_id].nil?
        #like comment
        @like = Like.new(user_id: current_user.id, comment_id: params[:like][:comment_id])
        @like.save
      elsif !params[:like][:post_id].nil? 
        # like post
        @like = Like.new(user_id: current_user.id, post_id: @post.id)
        @like.save
      end
    end
    redirect_to root_url
  end

private
  def post_params
    params[:post][:creator_id] = current_user.id
    params.require(:post).permit(:title, :content, :creator_id )
  end
  
  def comment_params
    params[:comment][:creator_id] = current_user.id
    params[:comment][:post_id] = params[:comment][:post_id]
    params.require(:comment).permit(:content, :post_id ,:creator_id )
  end
end
