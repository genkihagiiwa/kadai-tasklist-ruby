Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get 'toppages/index'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'

  
  get 'signup', to: 'users#new'
  
  
  resources :users, only: [:index, :show, :new, :create]
  resources :tasks
end
