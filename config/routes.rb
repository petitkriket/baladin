# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root to: 'passengers#index'
    resources :events
    resources :contacts, only: %i[new create]
    resources :passengers
    devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
    resources :users
    get ':shortcut' => redirect('/users/sign_up?t=%{shortcut}'), constraints: ->(request) { Passenger.where(shortcut: request[:shortcut]).any? }, id: :shortcut
    get 'a9' => redirect('/users/sign_up?t=a9')
  end
  get '/:locale' => 'passengers#index', :as => 'locale_root'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :passengers do
        resources :events
      end
      devise_scope :user do
        post   '/signin',       to: 'sessions#create'
        delete '/signout',      to: 'sessions#destroy'
        post   '/signup',       to: 'registrations#create'
        # put    '/account',      to: 'registrations#update'
        # delete '/account',      to: 'registrations#destroy'
        # put    '/password',     to: 'devise/passwords#update'
        # post   '/password',     to: 'devise/passwords#create'
        # get    '/confirmation', to: 'devise/confirmations#show'
        # post   '/unlock',       to: 'devise/unlocks#create'
        # get    '/unlock',       to: 'devise/unlocks#show'
      end
    end
  end
end
