Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :services, only: [:index, :show, :new, :create, :destroy]
end
