Rails.application.routes.draw do
  devise_for :users

  get 'home/feed'
  resources :questions

  root to: 'home#feed'
end
