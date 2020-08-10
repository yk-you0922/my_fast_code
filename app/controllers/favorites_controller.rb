class FavoritesController < ApplicationController
  before_action :set_post, except: :index

  def index
    @user = User.find(params[:id])
    @favorite_posts = @user.favorites.order(created_at: "DESC").collect{|favorite| favorite.post}
  end

  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    favorite.save
  end

  def destroy
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
end
