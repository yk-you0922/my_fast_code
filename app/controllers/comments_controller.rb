class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @new_comment = @post.comments.build(comment_params)
    @new_comment.user_id = current_user.id
    @new_comment.save(comment_params)
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    @post = @comment.post
    if @comment.user != current_user
      redirect_to request.referer
    end
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image, :user_id, :post_id)
  end
end
