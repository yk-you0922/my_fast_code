Rails.application.routes.draw do
  devise_for :admins
  # ユーザーがgoogle認証するための記述
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  root 'homes#top'
  get 'homes/about' => 'about'
  
  # ユーザー関連のルーティング
  resources :users do
    resource :relationship, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    get :ranking
  end

  # 投稿関連のルーティング
  resources :posts do 
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    get :ranking
  end

  # 管理者が管理する画面のルーティング
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :contact, only: [:index, :show, :update]
    resources :genre, except: [:new]
  end
end
