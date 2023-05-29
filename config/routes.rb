Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :products
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  

  root "products#index"

  namespace :admin do
    resources :users, only: %i[index edit update destroy] do
      post 'confirm_owner', on: :member
    end
    resources :categories, only: %i[new create edit update destroy]
    resources :products, only: %i[new create edit update destroy]
    resources :salons, only: %i[new create edit update destroy] do 
      resources :products, only: %i[new create edit update destroy]
    end
    resources :comments, only: %i[create edit update destroy]
    resources :rentals, only: %i[index new create edit update destroy]
  end

  namespace :owner do
    resources :salons, only: %i[new create edit update destroy] do
      resources :products, only: %i[new create edit update destroy]
      get :my_salons, to: 'salons#index'
    end
    resources :products, only: %i[new create edit update destroy]
    resources :comments, only: %i[create edit update destroy]
    resources :rentals, only: %i[new create edit update destroy]
  end

  namespace :user do
    resources :comments, only: %i[create edit update destroy]
  end
  post :request_owner_access, to: 'users#request_owner_access'

  resources :salons, only: %i[index show] do
    resources :comments, only: %i[create edit update destroy]
    resources :products, only: %i[new create edit update destroy]
  end
  resources :products, only: %i[index show] do
    get 'search', on: :collection
  end
  resources :categories, only: %i[index show]
  resources :users, only: %i[show edit update]
  resources :rentals, only: %i[show new create edit update destroy] do
    get :export_csv, on: :collection
    get :rate_salon, on: :member
    get :rate_user, on: :member
    post :update_salon_rating
    post :update_user_rating
    get 'confirm/:confirmation_token', to: 'rentals#confirm'
  end
end
