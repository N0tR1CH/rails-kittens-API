Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :kittens 
  resources :users
  resources :houses
  resources :companies
  post '/companies/:id/add_user', to: 'companies#add_user'
  root "kittens#index"
end
