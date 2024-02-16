class LikesController < ApplicationController
  before_action :set_post

  def new
       
    if params[:post_id]

      like_post
    elsif params[:postcomment_id]
      like_comment
    else
      redirect_back fallback_location: root_path, alert: 'Invalid like request.'
    end  
  end
def show
  destroy
end
  def destroy

    if params[:post_id]
      unlike_post
    elsif params[:postcomment_id]
      unlike_comment
    else
      redirect_back fallback_location: root_path, alert: 'Invalid unlike request.'
    end
  end
  
  private

  def set_post
    if params[:post_id]
      @post = Post.find_by(id: params[:post_id])
      @postcomment = nil
    elsif params[:postcomment_id]
      @postcomment = Postcomment.find_by(id: params[:postcomment_id])
      @post = nil
    else
      @post = nil
      @postcomment = nil
      redirect_back fallback_location: root_path, alert: 'Invalid parameters.'
      return
    end
  
    unless @post || @postcomment
      redirect_back fallback_location: root_path, alert: 'Post or Postcomment not found.'
    end
  end
  

  

  def like_post
      @post = Post.find(params[:post_id])

      if !@post.likes.exists?(user: current_user)
        @like = @post.likes.create(user: current_user)
          redirect_to post_path(@post), notice: 'Post liked successfully'
      else
       
        redirect_to post_path(@post), notice: 'You have only one like'
      end
  end

  def unlike_post
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
       redirect_to post_path(@post), notice: 'Post unliked successfully'
    else
      redirect_to post_path(@post), notice: 'You have not liked this post.'

    end
  end

  def like_comment
    @comment = Postcomment.find(params[:postcomment_id])
      if !@comment.likes.exists?(user: current_user)
            @like = @comment.likes.create(user: current_user)

        redirect_to post_path(@comment.post), notice: 'Comment liked successfully'
      else
       
        redirect_to post_path(@comment.post), notice: 'Failed to create like'
      end
    
  end

  def unlike_comment
    @comment = Postcomment.find(params[:postcomment_id])
    like = @comment.likes.find_by(user: current_user)
    if like
      like.destroy
      redirect_to post_path(@comment.post), notice: 'Comment unliked successfully'
    else
      redirect_to post_path(@comment.post), alert: 'You have not liked this comment.'
    end
  end
end