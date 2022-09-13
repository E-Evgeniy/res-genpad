Rails.application.routes.draw do
  devise_for :users
  resources :codes

  root to: 'codes#index'
end
