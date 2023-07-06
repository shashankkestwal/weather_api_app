Rails.application.routes.draw do 
  root to: "main#index"

  get "/cities", to: "cities#index"
  
  get "/signup", to: "registrations#new"
  post "/signup", to: "registrations#create"
  delete "/signout", to: "sessions#delete"
  
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  get "update_password", to: "passwords#edit"
  patch "update_password", to: "passwords#update" 

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
