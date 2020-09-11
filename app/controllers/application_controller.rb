class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!,:configure_permitted_parameters,
  if: :devise_controller?

  # サイドバー カテゴリーを展開するための変数
  before_action :get_genres
  def get_genres
    @get_genres = Genre.all
  end


  # 違うIDへの進入対策
  def current_user?
    user_id = params[:user_id]
    id = params[:id]
    unless user_id == current_user.id.to_s || id == current_user.id.to_s
      id = "#{params[:user_id]}" + "#{params[:id]}"
      redirect_to redirect_path(user_id: id)  #redirect先に入力されたIDを渡す
    end
  end

  #  違うユーザー同士のDM進入対策
    def dm_user?
      user1 = User.find(params[:user_id])
      user2 = current_user
      entry = Entry.where(room_id: params[:id])
      # 
      unless entry[1].user_id == user2.id && entry[1].room_id == params[:id].to_i
        redirect_to user_path(current_user)
      end
      unless params[:user_id].to_i == user2.id || entry.find_by(user_id: params[:user_id].to_i)
        redirect_to user_path(current_user)
      end
    end

  # ログイン後の遷移先を管理者とユーザーで場合わけ
  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_posts_path
      when User
        root_path
    end
  end

  def after_sign_out_path_for(resource)
      case resource
        when :admin
          new_admin_session_path
        when :user
          root_path
      end
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

end
