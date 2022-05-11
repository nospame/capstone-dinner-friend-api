Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/favorite_recipes" => "favorite_recipes#index"

  post "/favorite_recipes" => "favorite_recipes#create"
  patch "/favorite_recipes/:id" => "favorite_recipes#update"
  delete "/favorite_recipes/:id" => "favorite_recipes#destroy"

  get "/recipes" => "recipes#index"
  get "/recipes/:id" => "recipes#show"

  post "/sessions" => "sessions#create"

  get "/tags" => "tags#index"

  post "/users" => "users#create"

end
