Rails.application.routes.draw do
  get 'notifications/index'
  root "static_pages#home"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/districts", to: "address#districts"
  get "/wards", to: "address#wards"
  get "/notifitions", to: "notifications#index"

  resources :users
  resources :posts do
    resources :post_favorites, only: %i(create destroy), module: :posts
  end
  resources :notifications, only: %i(destroy update)
  mount ActionCable.server => '/cable'
end
