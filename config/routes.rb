Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'

  root to: "posts#index"
  post '/', to: 'posts#my_action'

  get '/users', to: "users#index"
  get '/user/:id', to: 'users#show', as: :user
  post '/user/:id', to: 'users#show'

  get '/my_profile', to: 'users#my_profile'
  patch '/my_profile', to: 'users#my_profile'

  get '/post/new', to: 'posts#new'
  post '/post/new', to: 'posts#create'
  get '/post/:id', to: 'posts#show'
  post '/post/:id', to: 'posts#my_comment'

  
  get '/liked', to: 'posts#my_like'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get "/signup", to: "devise/registrations#new"
    get "/login", to: "devise/sessions#new"
    get "/logout", to: "devise/sessions#destroy"
  end

  resources :posts, :comments
end
