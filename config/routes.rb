# frozen_string_literal: true

Rails.application.routes.draw do
  # Tools
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  scope do
    devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
  end

  # Rails API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events, only: [:create]
      resources :events do
        collection do
          get 'find'
        end
      end

      resources :passengers do
        resources :events
        resources :claims, only: %i[create]
      end
      get 'passengers/find/:shortcut' , to: 'passengers#find_by_shortcut'

      # should use out of the box devise_for :users instead
      devise_scope :user do
        get    '/contributions',to: 'events#contributions'
        post   '/signin',       to: 'sessions#create'
        delete '/signout',      to: 'sessions#destroy'
        post   '/signup',       to: 'registrations#create'
        get    '/confirmation', to: 'confirmations#confirm'
        get    '/account',      to: 'registrations#show'
        put    '/account',      to: 'registrations#update'
        delete '/account',      to: 'registrations#destroy'
        post   '/reset',        to: 'passwords#reset'
        patch  '/password',     to: 'passwords#update'
      end
    end
  end

  # Vue frontend
  root to: 'home#index'
  get '/*path', to: 'home#index', format: false
end
