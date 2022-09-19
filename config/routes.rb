Rails.application.routes.draw do
  devise_for :users
  resources :codes
  resources :tests
  resources :addresses

  root to: 'codes#index'
end
