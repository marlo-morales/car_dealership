Rails.application.routes.draw do
  root "posts#index"

  get "/login", to: "login#new"
  post "/login", to: "login#create"
  delete "/logout", to: "login#destroy"

  resources :posts, except: :index
end
