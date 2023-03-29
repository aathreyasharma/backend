require 'sidekiq/web'
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#index"
  resources :users
  mount Sidekiq::Web => "/sidekiq"
  match "*path", to: "application#fallback", via: :all
end
