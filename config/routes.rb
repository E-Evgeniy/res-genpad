Rails.application.routes.draw do
  devise_for :users
  resources :codes
  resources :tests

  root to: 'codes#index'
end
