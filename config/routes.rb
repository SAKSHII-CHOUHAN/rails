Rails.application.routes.draw do
  get "restaurants/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root "home#index"
  resources :dashboard, only: [ :index ]
  
  resources :tables, only: [:index, :show]
  resources :orders do
    member do
      delete 'remove_order_item/:order_item_id', to: 'orders#remove_order_item', as: :remove_order_item
    end
  end
  
  resources :payments, only: [:new, :create]

  resources :order_items, only: [:show]
  resources :tables do
    post 'create_order', to: 'orders#create'
  end
  
  resources :restaurants do
    resources :feedbacks, only: [:index, :new, :create]
  end
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
end
