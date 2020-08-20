class CommentFavoritesController < ApplicationController
  before_action :set_comment

  def create
    comment_favorite = current_user.comment_favorites.build(comment_id: params[:comment_id])
    comment_favorite.save!
    redirect_to request.referer
  end

  def destroy
    comment_favorite = CommentFavorite.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    comment_favorite.destroy
    redirect_to request.referer
  end

  private

  def set_comment
    # @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
  end

end
