Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/  do
    root to: 'passengers#index'
    resources :events
    resources :contacts, only: [:new, :create]
    resources :passengers
    devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
    resources :users
    get ":shortcut" => redirect("/users/sign_up?t=%{shortcut}"), constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? },  id: :shortcut
    get "a9" => redirect("/users/sign_up?t=a9")
    #ok#get ':shortcut', to: 'events#new', constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? }
    #get ':shortcut', to: 'devise/registrations#new', constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? }
  end
    get '/:locale' => 'passengers#index', :as => 'locale_root'
end
