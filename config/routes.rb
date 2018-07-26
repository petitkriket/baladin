Rails.application.routes.draw do
  scope "(:locale)", locale: /en|fr/ do
    resources :events
    resources :passengers
    root to: 'passengers#index'
    devise_for :users, controllers: { registrations: 'users/registrations' }
    resources :users
  end
end
