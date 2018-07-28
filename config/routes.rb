Rails.application.routes.draw do
  scope "(:locale)", locale: /en|fr/ do
    resources :events
    resources :passengers
    root to: 'passengers#index'
    devise_for :users, controllers: { registrations: 'users/registrations' }
    resources :users
    #get ":language" => redirect("/users/sign_up"), constraints: lambda { |request| Passenger.where(shortcut: request[:language]).any? }
    get ':shortcut', to: 'events#new', constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? }
  end
end
