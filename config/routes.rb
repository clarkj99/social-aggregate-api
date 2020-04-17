Rails.application.routes.draw do
  resources :ratings
  resources :commentsses
  resources :posts
  resources :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
