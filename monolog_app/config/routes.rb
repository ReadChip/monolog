Rails.application.routes.draw do
  root 'sites#top'
  get '/all', to: 'users#all_users'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/edit', to: 'users#edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, param: :user_id do
    collection do
      get :liking, :likers
    end
  end 

  resources :account_activations, only: [:edit]
  resources :microposts,          only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy]
  

end