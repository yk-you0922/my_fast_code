class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @new_comment = @post.comments.new(comment_params)
    @new_comment.post_id = @post.id
    @new_comment.user_id = current_user.id
    if @new_comment.save
    else
      redirect_to request.referer
    end
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    @post = @comment.post
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image, :user_id, :post_id)
  end
end
