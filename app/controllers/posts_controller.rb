class PostsController < ApplicationController
  before_action :authenticate_user!

def index
    @posts = Post.all
  end

  def show
   
    @post = Post.friendly.find_by_slug(params[:slug])

    @comments = @post.postcomments.includes(:user)
    @comment = Postcomment.new 
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_path, alert: 'You are not authorized to delete this post.'
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.post.build(post_params)
     @post.slug = @post.content.parameterize

 

    if @post.save

      redirect_to root_path, notice: 'Post was successfully created.'
    else
      # If there is an error, render the new page again
      render 'new'
    end
  end

  def comment
    @post = Post.find(params[:id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save

      redirect_to @post, notice: 'Comment added!'
    else
      render 'show'
    end
  end

  private

  def post_params
     params.require(:post).permit(:content, :tittle)

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
