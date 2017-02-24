Rails.application.routes.draw do
  resources :players, :locations

  resources :practices
  resources :attendances

  get 'users/edit'
  get 'users/show'

  devise_for :users

  root to: "home#index"

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

  resources :slack_bots, only: [:index]
  namespace :slack_bots do
    get 'authorize'
    get 'callback'
  end

  resources :report, only: [:index, :download]
end
