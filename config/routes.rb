Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }
  resources :codes
  resources :tests
  resources :addresses

  root to: 'generals#index'

  get 'general', to: 'generals#index', as: :general
end
