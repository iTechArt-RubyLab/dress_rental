Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "pages#home"

  namespace :admin do
    resources :users, only: %i[index edit update destroy] do
      post 'confirm_owner', on: :member
    end
    resources :categories, only: %i[new create edit update destroy]
    resources :products, only: %i[new create edit update destroy]
    resources :salons, only: %i[new create edit update destroy]
    resources :comments, only: %i[create edit update destroy]
    resources :rentals, only: %i[index new create edit update destroy]
  end

  namespace :owner do
    resources :categories, only: %i[new create edit update destroy]
    resources :products, only: %i[new create edit update destroy]
    resources :salons, only: %i[new create edit update destroy]
    resources :comments, only: %i[create edit update destroy]
    resources :rentals, only: %i[new create edit update destroy]
  end

  namespace :user do
    resources :comments, only: %i[create edit update destroy]
    # resources :rentals, only: %i[new create edit update destroy] !!!
  end

  resources :salons, only: %i[index show] do
    resources :comments, only: %i[create edit update destroy]
  end
  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]
  resources :users, only: %i[show edit update]
  resources :rentals, only: %i[show new create edit update destroy]
end
