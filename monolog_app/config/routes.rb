Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'sites#top'
  get '/all', to: 'users#all_users'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/edit', to: 'users#edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/refresh', to: 'sites#refresh'
  get '/bell', to: 'users#bell'
  get '/mypage', to: 'users#mypage'
  resources :users, param: :user_id do
    collection do
      get :liking, :likers
    end
  end 

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy]
  resources :blocklists,       only: [:create, :destroy]
  
  get '*path', controller: 'application', action: 'render_404'

end