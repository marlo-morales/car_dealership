Rails.application.routes.draw do
  root "posts#index"

  get "/login", to: "login#new"
  post "/login", to: "login#create"

  resources :posts, except: :index
end
