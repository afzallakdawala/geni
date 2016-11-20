Rails.application.routes.draw do
  get '/dashboard', to: "dashboard#index", as: "dashboard"
  get '/dashboard/user/:id', to: "dashboard#user", as: "user_dashboard"

  devise_for :admin_users
  resources :timelogs
  root 'landing#index'
  resource :users
end
