Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root "home#index"
  # get "dashboard/index"
  resources :dashboard
  resources :menu_items
  
  resources :tables
  resources :orders do
    member do
      get 'edit', to: 'orders#edit', as: :edit
      patch 'completed', to: 'orders#complete_order', as: :complete
    end
  end
  
  resources :order_items
  resources :tables do
    post 'create_order', to: 'orders#create'
  end
  
  devise_for :users

  # authenticated :user do
  #   root 'dashboard#index', as: :authenticated_root
  # end
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # root "users/registration#new"
end
