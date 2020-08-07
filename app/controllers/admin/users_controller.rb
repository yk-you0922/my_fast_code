class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
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
      redirect_to admin_users_path
    else
      render :edit
      @user = User.find(params[:id])
    end
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
