Rails.application.routes.draw do
  resources :codes

  root to: 'codes#index'
end
