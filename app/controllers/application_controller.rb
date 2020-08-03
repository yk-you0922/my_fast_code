class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!,:configure_permitted_parameters,
  if: :devise_controller?

  # 違うIDへの進入対策、後ほどコメントアウト削除し、修正で実装
  # def current_user?
  #   user_id = params[:user_id]
  #   id = params[:id]
  #   unless user_id == current_user.id.to_s || id == current_user.id.to_s
  #     id = "#{params[:user_id]}" + "#{params[:id]}"
  #     redirect_to redirect_path(user_id: id)  #redirect先に入力されたIDを渡す
  #   end
  # end

  # ログイン後の遷移先を管理者とユーザーで場合わけ
  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_posts_path
      when User
        root_path

    end
  end

  # 新規会員登録後はwelcomingページ(homes#welcome)へ飛ぶように
  # def after_sign_up_path_for(resource)
  #     welcoming_path
  # end

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
