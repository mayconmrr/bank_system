Rails.application.routes.draw do
   
  get 'static_pages/home'

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users 

  resources :statements
  post 'statements/report' => 'statements#report'
 
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
