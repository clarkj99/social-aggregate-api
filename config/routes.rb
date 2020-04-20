Rails.application.routes.draw do
  get "/timelines/:user_id", to: "timelines#show", as: "timelines"
  # resources :ratings, only: [:index, :show, :create]
  # resources :comments, only: [:index, :show, :create]
  # resources :posts, only: [:index, :show, :create, :update]
  # resources :users, only: [:index, :show, :create, :update]
  resources :ratings
  resources :comments
  resources :posts
  resources :users
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
