Rails.application.routes.draw do
  
  root 'pages#home'

  get '/home', to: 'pages#home'
  
  # recipes
  resources :recipes do
    member do
      post 'like'
    end
  end
  
  # chefs
  resources :chefs, except: [:new, :destroy]
  
  # Authentication
  get '/register', to: 'chefs#new'
  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
  
  # styles
  resources :styles, only: [:new, :create, :show]
  
  # ingredients
  resources :ingredients, only: [:new, :create, :show]
  
end
