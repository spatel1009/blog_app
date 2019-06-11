Rails.application.routes.draw do
  devise_for :users
  
  resources :articles do
    resources :comments
  end

  root to: 'articles#index'

  mount ActionCable.server => '/cable'
end
