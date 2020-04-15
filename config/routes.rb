Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :reviews
  
end
