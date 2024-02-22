Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root 'ways#index'
  resources :landingpage
  resources :homepage

  resources :posts, param: :slug
 
  resources :likes


  resources :postcomments
end