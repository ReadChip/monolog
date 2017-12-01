Rails.application.routes.draw do
  root 'sites#top'
  resources :users, param: :user_id
  get '/index', to: 'users#index'
  get '/all', to: 'users#all_users'
  get '/edit', to: 'users#edit'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    collection do
      get :liking, :likers
    end
  end

  resources :account_activations, only: [:edit]
  resources :microposts,          only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy]

end