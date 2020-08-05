class UsersController < ApplicationController

  before_action :authenticate_user!, except: :index

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @favorite_posts = @user.favorites.map{|favorite| favorite.post}
    # 自分がお気に入りした数
    # @favorites_count = @user.favorites_posts.map{|favorite| favorite}
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      @user = User.find(params[:id])
      render :show
    end
  end

  # ユーザーが退会したときの処理
  def hide
    @user = User.find(params[:id])
    @user.update(is_withdrawal_flag: false)
    reset_session
    redirect_to root_path
  end

  def follows
  end

  def followers
  end

  private

  def user_params
    params.require(:user).permit(
      :name, 
      :introduction, 
      :image, 
      :is_sex_flag, 
      :is_withdrawal_flag
    )
  end

end
