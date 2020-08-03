Rails.application.routes.draw do
  devise_for :admins
  # ユーザーがgoogle認証するための記述
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
   }
   
   def devise_scope(scope)
    constraint = lambda do |request|
      request.env["devise.mapping"] = Devise.mappings[scope]
      true
    end
 
    constraints(constraint) do
      yield
    end
  end


  # homes関連のルーティング
  root 'homes#top'
  get 'homes/about' => 'about'
  get 'welcome' => 'homes#welcome', as: 'welcoming'
  
  # ユーザー関連のルーティング
  resources :users do
    resource :relationship, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    get :ranking
  end
  get 'withdrawal' => 'users#withdrawal'
  put "/users/:id/hide" => "users#hide", as: 'user_hide'


  # 投稿関連のルーティング
  resources :posts do 
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    get :ranking
  end

  # 管理者が管理する画面のルーティング
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :contacts, only: [:index, :show, :update]
    resources :genres, except: [:new]
  end
end
