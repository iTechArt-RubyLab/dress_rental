Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "pages#home"

  resources :users, only: %i[show]
  resources :rentals, only: %i[new create edit update show destroy]

  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]

  namespace :admin do
    resources :products, only: %i[index new create edit update destroy]
    resources :categories, only: %i[index new create edit update destroy]
  end
end
