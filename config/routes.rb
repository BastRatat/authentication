Rails.application.routes.draw do
  resources :requests do
      resources :volunteers, only: [:create, :index]
  end

  # ROUTES FOR VOLUNTEERS
  get '/volunteer/:id', to: "volunteers#show"
  patch '/volunteer/:id', to: "volunteers#update"
  put '/volunteer/:id', to: "volunteers#update"
  delete '/volunteer/:id', to: "volunteers#destroy"

  resources :users, only: [:create]
  post '/login', to: 'users#login'
  get '/auto_login', to: 'users#auto_login'
  get '/users', to: 'users#index'
end
