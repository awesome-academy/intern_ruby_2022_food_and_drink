Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    root to: "dashboard#index"
    devise_for :users, skip: :omniauth_callbacks
    resources :dashboard, only: %i(index show)
    resources :rooms
    resources :messages
    # Auth
    get "auth/register", to: "auth#new"
    get "auth/login"
    get "auth/logout"
    post "auth/create"
    post "auth/handle_login"

    # Admin
    namespace :admin do
      get "home/index"
      resources :categories
      resources :users
      resources :products
      resources :orders
    end
  end
end
