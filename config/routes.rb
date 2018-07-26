Rails.application.routes.draw do
  resources :events
  resources :passengers
  root to: 'passengers#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users
end
