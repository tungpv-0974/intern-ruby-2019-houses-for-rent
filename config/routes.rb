Rails.application.routes.draw do
  root "static_pages#home"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/districts", to: "address#districts"
  get "/wards", to: "address#wards"

  resources :users
  resources :posts do
    resources :post_favorites, only: %i(create destroy), module: :posts
  end
  resources :notifications, only: %i(update destroy)
  mount ActionCable.server => '/cable'
end
