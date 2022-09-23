Rails.application.routes.draw do
  devise_for :users
  resources :codes
  resources :tests
  resources :addresses

  root to: 'generals#index'

  get 'general', to: 'generals#index', as: :general
end
