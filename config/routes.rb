Rails.application.routes.draw do
  resources :attendances
  resources :locations
  resources :practices

  get 'users/edit'
  get 'users/show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  #api
  namespace :api do
    namespace :v1 do
      get 'users/me', to: 'users#me'
      resources :users, only: [:me, :index, :create, :show, :update, :destroy]
    end
  end
end
