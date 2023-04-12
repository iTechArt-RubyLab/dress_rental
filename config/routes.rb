Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "products#index"

  get "/categories" => "categories#show"
  get "/admin" => "pages#admin"
  get "/home" => "pages#home"

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  namespace :admin do
    root "products#index"
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
