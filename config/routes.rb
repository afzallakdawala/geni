Rails.application.routes.draw do
  devise_for :admin_users
  resources :timelogs
  root 'landing#index'
  resource :users
end
