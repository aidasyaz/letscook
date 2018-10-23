Rails.application.routes.draw do
  root 'recipes#index' 
  
  # sessions
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  # login logout session
  resources :sessions, only: [:create]
  # new user registration
  resources :users, only: [:new, :create]

end
