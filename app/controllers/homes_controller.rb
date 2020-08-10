class HomesController < ApplicationController
  before_action :authenticate_user!, only: :welcome
  
  def top
  end

  def about
  end

  def welcome
  end

  def redirect
    # 直前に入力された値を受け取って表示する
    @id = params[:user_id]
  end

end
