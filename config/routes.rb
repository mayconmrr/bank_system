Rails.application.routes.draw do
  
  get 'static_pages/home'

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users 
 
  resources :accounts do
  	member do
      post :deposit 
      post :withdraw
  	end
  end

  root 'static_pages#home' 

end
