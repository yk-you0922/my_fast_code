class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :current_user?, only: [:edit, :update]

  def index
    @users = User.all.order(created_at: "DESC").page(params[:page]).per(1)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: "DESC").page(params[:page]).per(1)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
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
