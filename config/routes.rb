Rails.application.routes.draw do
  
  resource :session, only: [:new, :create, :destroy]
  get 'profile', to: 'users#profile'
  resources :users
  resources :questions, except: [:update, :edit] do 
    resources :answers
  end
  root 'users#index'

  namespace :api do
    resource :session, only: [:create]
    get 'profile', to: 'users#profile'
    resources :users, only: [:index, :create, :update, :show, :destroy]
    resources :questions, except: [:new, :update, :edit] do 
      resources :answers, except: [:new, :edit]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
