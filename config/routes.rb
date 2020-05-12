Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  get "alltags", to: "static_pages#alltags"
  root 'static_pages#home'
  resources :restaurants, only: [:new, :create, :destroy] do
    resources :reviews do
      resources :comments
    end
  end
  resources :likes, only: [:create, :destroy]
  resources :notifications, only: :index

end
