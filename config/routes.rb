Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "pages#home"

  get "/categories" => "categories#index"
  get "/products" => "products#index"
  get "/admin" => "pages#admin"
  get "/home" => "pages#home"
  get "/login" => "categories#index"
  get "/sign_up" => "registrations#new"

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  namespace :admin do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
