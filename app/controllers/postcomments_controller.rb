class PostcommentsController < ApplicationController
	def create
    
      @post = Post.find(params[:postcomment][:post_id])
      @comment = @post.postcomments.build(comment_params.merge(user: current_user))
  
      if @comment.save
       
        redirect_to @post, notice: 'Comment added successfully.'
      else
        
        redirect_to @post, notice: 'Failed to add comment.'
      end
  end

  

  
    # def destroy
    #   @comment = Postcomment.find(params[:id])
    #   @comment.destroy
    #   redirect_to @comment.post, notice: 'Comment deleted successfully.'
    # end
  
    private
  
    def comment_params
      params.require(:postcomment).permit(:content, :user_id)
    end
  end
 	
