Rails.application.routes.draw do
  resources :players
  resources :attendances
  resources :locations
  resources :practices

  get 'users/edit'
  get 'users/show'

  devise_for :users

  root to: "home#index"
  post "/authorize_bot", to: "home#authorize_bot"
  get "/callback", to: "home#callback"

  #api
  namespace :api do
    namespace :v1 do
      get 'users/me', to: 'users#me'
      resources :users, only: [:me, :index, :create, :show, :update, :destroy]
      resources :attendances
      resources :locations
      resources :practices
      resources :players
    end
  end
end
