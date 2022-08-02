Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :kittens 
  resources :users
  resources :houses
  resources :companies
  root "kittens#index"
end
