Rails.application.routes.draw do
  get 'search/search'
  get 'genres/index'
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
  get 'redirect' => 'homes#redirect'
  
  # ユーザー関連のルーティング
  resources :users do
    resource :relationship, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    resources :contacts, only: [:new, :index, :show, :create]
  end
  get 'withdrawal' => 'users#withdrawal'

  # ユーザーお気に入り関連のルーティング
  get '/users/:id/favorites' => 'favorites#index', as: 'user_favorites'
  get '/users/:id/favorite_comments' => 'comment_favorites#index', as: 'user_favorite_comments'

  # ジャンル関連のルーティング
  get '/genres' => 'genres#index'
  get '/genres/:genre_id/posts' => 'posts#category', as: 'category_posts'

  # 投稿関連のルーティング
  resources :posts do 
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end


  # 管理者が管理する画面のルーティング
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :contacts, only: [:index, :show, :update]
    resources :genres, except: [:new]
  end

  get 'search' => 'search#search'

  # コメントのお気に入りルーティング
  resources :comments do 
    resource :comment_favorites, only: [:create, :destroy]
  end

end
