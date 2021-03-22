Rails.application.routes.draw do
  root "cars#index"

  get "/login", to: "login#new"
  post "/login", to: "login#create"
  delete "/logout", to: "login#destroy"

  resources :cars, except: %i(index show) do
    member do
      get :thank_you
      get :buy
      post :sold
      post :unsold
    end
  end
end
