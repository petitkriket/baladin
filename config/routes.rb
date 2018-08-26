Rails.application.routes.draw do
#scope "(:locale)", locale: /en|fr/ do
scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :events
    resources :contacts, only: [:new, :create]
    resources :passengers
    root to: 'passengers#index'
    devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
    resources :users
    get ":shortcut" => redirect("%{locale}/users/sign_up?t=%{shortcut}"), constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? },  id: :shortcut
    #ok#get ':shortcut', to: 'events#new', constraints: lambda { |request| Passenger.where(shortcut: request[:shortcut]).any? }
  end

    root to: redirect("/#{I18n.locale}", status: 302), as: :redirected_root
    get "/*path", to: redirect("/#{I18n.locale}/%{path}", status: 302), constraints: { path: /(?!(#{I18n.available_locales.join("|")})\/).*/ }, format: false
end
