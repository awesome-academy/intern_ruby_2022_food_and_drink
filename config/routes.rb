Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    root to: "dashboard#index"
    devise_for :users, skip: :omniauth_callbacks
    resources :dashboard, only: %i(index show)
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

  namespace :api do
    namespace :v1 do
      resources :users
      resources :products
      resources :categories
      resources :orders
      post "login", to: "auth#login"
      patch "orders/update-status/:id", to: "orders#update_status"
    end
  end
end
