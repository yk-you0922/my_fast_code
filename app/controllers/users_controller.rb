class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :current_user?, only: [:edit, :update, :hide]

  def index
    @users = User.order(created_at: "DESC").page(params[:page]).per(1)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: "DESC").page(params[:page]).per(1)
    @favorite_posts = @user.favorites.map{|favorite| favorite.post}
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
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
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
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
