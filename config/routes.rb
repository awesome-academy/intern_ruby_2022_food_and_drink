Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: 'dashboard#index'
    resources :dashboard, only: %i(index show)
    get 'carts', to: "carts#index"
    post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
    post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
    post 'line_items' => "line_items#create"
    get 'line_items/:id' => "line_items#show", as: "line_item"
    delete 'line_items/:id' => "line_items#destroy"
    resources :orders do
      member do
        patch :change_status
      end
    end
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
