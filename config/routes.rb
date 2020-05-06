Rails.application.routes.draw do
  get 'restaurants/new'
  post 'restaurants/create'
  get 'restaurants/destroy'
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root 'static_pages#home'
  resources :reviews do
    resources :comments
  end
  resources :likes, only: [:create, :destroy]
  resources :notifications, only: :index

end
