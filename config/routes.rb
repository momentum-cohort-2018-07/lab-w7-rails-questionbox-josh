Rails.application.routes.draw do
 
  resource :session, only: [:new, :create, :destroy]
  resources :users
  resources :questions, except: [:update, :edit] do 
    resources :answers
  end
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
