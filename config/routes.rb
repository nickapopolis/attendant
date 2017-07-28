Rails.application.routes.draw do
  
  devise_for :users
  root to: 'landing#index'

  resources :records
  resource :dashboard, only: [:show]
end
