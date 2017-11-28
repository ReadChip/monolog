Rails.application.routes.draw do
  root 'sites#top'
  get '/index', to: 'users#index'
  get '/all', to: 'users#all_users'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :liking, :likers
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :microposts,          only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy]
end