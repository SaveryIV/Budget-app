Rails.application.routes.draw do
  get 'pages/splash'
  get 'pages/about'
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root :to => 'groups#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'pages#splash', as: :unauthenticated_root
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :groups, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :shoppings
  end

  resources :users, only: [:show, :edit, :update, :destroy]
end
