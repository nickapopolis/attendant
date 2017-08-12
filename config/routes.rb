Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users
  root to: 'landing#index'

  defaults format: :json do
    resources :records, only: [:index, :show, :create, :update, :delete]
  end

  resource :dashboard, only: [:show]
end
