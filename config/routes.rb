Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: {
    :omniauth_callbacks => "omniauth_callbacks",
    :registrations => 'users/registrations'
  }
  root 'static_pages#home'
  resources :reviews
  resources :likes, only: [:create, :destroy]

end
