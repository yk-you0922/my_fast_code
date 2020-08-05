class FavoritesController < ApplicationController
  before_action :set_post
  
  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
    # redirect_to request.referer
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
end
