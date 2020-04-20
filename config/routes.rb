Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"

  get '/users/:id', to: 'users#show', as: :user
  post '/users/:id', to: 'users#show'

  get '/my_profile', to: 'users#my_profile'
  patch '/my_profile', to: 'users#my_profile'

  devise_scope :user do
    get "/signup", to: "devise/registrations#new"
    get "/login", to: "devise/sessions#new"
    get "/logout", to: "devise/sessions#destroy"
  end
end
