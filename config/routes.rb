Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "pages#home"

  resources :salons, only: %i[index show] do
    resources :comments, only: %i[create edit update destroy]
  end
  resources :users, only: %i[show]

  namespace :admin do
    resources :users, only: %i[index edit update]
    resources :categories, only: %i[edit update]
    resources :products, only: %i[new create edit update destroy]
    resources :comments, only: %i[create edit update destroy]
    resources :rentals, only: %i[index]
  end

  resources :rentals, only: %i[new create edit update show destroy]

  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]
end
