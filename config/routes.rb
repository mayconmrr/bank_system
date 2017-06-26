Rails.application.routes.draw do
  
  resources :statements
  get 'static_pages/home'

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users 

  resources :statements 
 
  resources :accounts do
  	member do
      post :deposit 
      post :withdraw
      post :transfer
      post :close_account
  	end
  end

  root 'static_pages#home' 

end
