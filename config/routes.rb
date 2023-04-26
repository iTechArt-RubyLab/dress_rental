Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "pages#home"

  resources :salons, only: %i[index show] do
    resources :comments, only: %i[create destroy]
  end
  
  resources :users, only: %i[show]
  resources :rentals, only: %i[new create edit update show destroy]

  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]
end
