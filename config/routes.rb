Rails.application.routes.draw do
  
  get 'static_pages/home'

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :balances
  resources :accounts
  resources :users 

  root 'static_pages#home' 

end
