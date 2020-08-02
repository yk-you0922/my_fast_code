class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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

  def hide
  end

  def follows
  end

  def followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image, :sex, :is_withdrawal_flag)
  end

end
