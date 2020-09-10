class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      @user = current_user
      @room = @message.room.id
      redirect_to request.referer
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
