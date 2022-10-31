Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources :tests do
    resources :comments
  end
  
  resources :addresses

  root to: 'generals#index'

  get 'general', to: 'generals#index', as: :general
  #get 'find_test', to: 'generals#find', as: :find_test

  get 'find_test', to: 'find_tests#find', as: :find_test
  get 'result', to: 'find_tests#result', as: :result

  mount ActionCable.server => '/cable'

end
