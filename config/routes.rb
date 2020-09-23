Rails.application.routes.draw do

  # NESTED ROUTES FOR REQUESTS
  resources :requests do
    resources :volunteers, only: [:create, :index]
    resources :chats, only: [:create, :index]
  end

  # ROUTES FOR MESSAGES
  get '/chat/:chat_id/messages', to: "messages#index"
  post '/chat/:chat_id/messages', to: "messages#create"

  # ROUTES FOR CHATS
  get '/chat/:id', to: "chats#show"
  patch '/chat/:id', to: "chats#update"
  put '/chat/:id', to: "chats#update"
  delete '/chat/:id', to: "chats#destroy"

  # ROUTES FOR VOLUNTEERS
  get '/volunteer/:id', to: "volunteers#show"
  patch '/volunteer/:id', to: "volunteers#update"
  put '/volunteer/:id', to: "volunteers#update"
  delete '/volunteer/:id', to: "volunteers#destroy"

  # ROUTES FOR AUTHENTICATION
  resources :users, only: [:create]
  post '/login', to: 'users#login'
  get '/auto_login', to: 'users#auto_login'
  get '/users', to: 'users#index'
  get '/user/:id', to: 'users#show'
end
