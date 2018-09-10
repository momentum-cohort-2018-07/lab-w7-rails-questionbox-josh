Rails.application.routes.draw do
  get 'questions/index'
  get 'questions/new'
  get 'questions/show'
  resource :session, only: [:new, :create, :destroy]
  resources :users
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
