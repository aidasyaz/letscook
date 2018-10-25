Rails.application.routes.draw do
  root 'recipes#index' 
  
  # sessions
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  # login logout session
  resources :sessions, only: [:create]
  
  # user
  resources :users
  # recipes
  resources :recipes
 
 get "/auth/:provider/callback" => "sessions#create_from_omniauth"




end
