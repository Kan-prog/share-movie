Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  get 'rankings/like', to: 'rankings#like'
  
  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get :like_reviews
      get :stock_reviews
    end
  end
  
  get 'search', to: 'reviews#search' 
  resources :reviews, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      get :like_users
      get :stock_users
    end  
  end  
  resources :favorites, only: [:create, :destroy]
end
