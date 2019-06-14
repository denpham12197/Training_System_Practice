Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/courses/:id/member", to: "courses#member"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :courses
  resources :static_pages
end
