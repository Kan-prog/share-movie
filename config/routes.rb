Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get :like_reviews
      get :stock_reviews
    end
  end  
  resources :reviews, only: [:new, :create, :show, :edit, :update, :destroy] do
    member do
      get :like_users
      get :stock_users
    end  
  end  
  resources :favorites, only: [:create, :destroy]
end
