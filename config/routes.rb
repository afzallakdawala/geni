Rails.application.routes.draw do
  get '/dashboard', to: "dashboard#index", as: "dashboard"

  devise_for :admin_users
  resources :timelogs
  root 'landing#index'
  resource :users
end
