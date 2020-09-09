Rails.application.routes.draw do
  get 'search/search'
  get 'genres/index'
  devise_for :admins
  # SNS_login_or_signup_routing
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  def devise_scope(scope)
    constraint = lambda do |request|
      request.env['devise.mapping'] = Devise.mappings[scope]
      true
    end

    constraints(constraint) do
      yield
    end
  end

  # homes_routing
  root 'homes#top'
  get 'homes/about' => 'about'
  get 'welcome' => 'homes#welcome', as: 'welcoming'
  get 'redirect' => 'homes#redirect'

  # Users_routing
  resources :users do
    resource :relationship, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    resources :contacts, only: [:new, :index, :show, :create]
    resources :messages, only: :create
    resources :rooms, only: [:create, :show, :index]
  end
  get 'withdrawal' => 'users#withdrawal'

  # User_favorite_routing
  get '/users/:id/favorites' => 'favorites#index', as: 'user_favorites'
  get '/users/:id/favorite_comments' => 'comment_favorites#index', as: 'user_favorite_comments'

  # Genre_routing
  get '/genres' => 'genres#index'
  get '/genres/:genre_id/posts' => 'posts#category', as: 'category_posts'

  # Posts_routing
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end


  # Admin_routing
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :contacts, only: [:index, :show, :update]
    resources :genres, except: [:new]
  end

  get 'search' => 'search#search'

  # Comment_favortite_routing
  resources :comments do
    resource :comment_favorites, only: [:create, :destroy]
  end

end
