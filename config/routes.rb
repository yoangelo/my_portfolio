Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root 'static_pages#home'
  resources :reviews do
    resources :comments, only: [:create,:destroy]
  end
  resources :likes, only: [:create, :destroy]
  resources :notifications, only: :index

end
