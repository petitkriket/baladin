Rails.application.routes.draw do
  resources :passengers
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
