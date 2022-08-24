Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :dashboard, only: %i(index show)
    get 'carts', to: "carts#index"
    post 'line_items/change_qty/:id' => "line_items#change_quantity", as: "line_item_change_quantity"
    post 'line_items' => "line_items#create"
    get 'line_items/:id' => "line_items#show", as: "line_item"
    delete 'line_items/:id' => "line_items#destroy"

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
    end
  end
end
