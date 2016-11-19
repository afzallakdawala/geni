Rails.application.routes.draw do
  resources :timelogs
  root 'landing#index'
  resource :users
end
