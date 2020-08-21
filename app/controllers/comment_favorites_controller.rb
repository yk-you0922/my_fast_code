class CommentFavoritesController < ApplicationController
  before_action :set_comment, except: :index

  def index
    @user = User.find(params[:id])
    @comment_favorites = @user.comment_favorites.order(created_at: "DESC").collect{|favorite_comment| favorite_comment.comment}
  end

  def create
    @comment_favorite = current_user.comment_favorites.build(id: params[:comment_favorite_id], comment_id: params[:comment_id])
    @comment_favorite.save
  end

  def destroy
    @comment_favorite = CommentFavorite.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @comment_favorite.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

end
