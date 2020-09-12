class RoomsController < ApplicationController
  before_action :authenticate_user!
  # before_action :dm_user?, only: :show
  before_action :current_user?, only: :index

  def create
    @room = Room.create
    @user = User.find(params[:user_id])
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/users/#{@user.id}/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    @user1 = current_user
    @user2 = User.find(params[:user_id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages.order(created_at:"DESC")
      @new_message = Message.new
      @entries = @room.entries
      @room_user = @entries.where(user_id: :room_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @currentEntries = current_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @another_entries = Entry.where(room_id: myRoomIds).where.not(user_id: current_user.id)

  end


end
