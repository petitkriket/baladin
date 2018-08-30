Rails.application.routes.draw do
  scope "(:locale)", locale: /en|fr/ do
    resources :events
    resources :contacts, only: [:new, :create]
    resources :passengers
    root to: 'passengers#index'
    devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
    resources :users
    get ":shortcut" => redirect("/users/sign_up?t=%{shortcut}"), constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? },  id: :shortcut
    #ok#get ':shortcut', to: 'events#new', constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? }
    #get ':shortcut', to: 'devise/registrations#new', constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? }
  end
end
  
