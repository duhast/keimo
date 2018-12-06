Rails.application.routes.draw do
  devise_for :users

  get 'home/feed'
  get 'home/topics', as: :topics

  resources :questions do
    member do
      patch :follow
      patch :vote
    end
    resources :answers, only: [:create, :delete] do
      patch :vote, on: :member
    end
  end
  patch 'users/:user_id/follow', to: 'users#follow', as: :follow_user

  root to: 'home#feed'
end
