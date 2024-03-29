Rails.application.routes.draw do

  # NESTED ROUTES FOR REQUESTS
  resources :requests do
    resources :volunteers, only: [:create, :index]
    resources :chats, only: [:create, :index]
  end

  # ROUTE TO GET REQUEST TOTAL
  get '/total', to: "requests#total"
  delete '/requests', to: "requests#remove_all"


  # ROUTE FOR UPLOAD A FILE
  get '/files', to: "papers#index"
  get '/file/:id', to: "papers#show"
  post '/user/:user_id/file', to: "papers#create"
  delete '/file/:id', to: "papers#destroy"

  # ROUTES FOR MESSAGES
  get '/chat/:chat_id/messages', to: "messages#index"
  post '/chat/:chat_id/messages', to: "messages#create"
  get '/messages', to: "messages#total"
  delete '/messages', to: "messages#remove_all"

  # ROUTES FOR CHATS
  get '/chats', to: "chats#total"
  get '/chat/:id', to: "chats#show"
  patch '/chat/:id', to: "chats#update"
  put '/chat/:id', to: "chats#update"
  delete '/chat/:id', to: "chats#destroy"
  delete '/chats', to: "chats#remove_all"

  # ROUTES FOR VOLUNTEERS
  get '/volunteers', to: "volunteers#total"
  get '/volunteer/:id', to: "volunteers#show"
  patch '/volunteer/:id', to: "volunteers#update"
  put '/volunteer/:id', to: "volunteers#update"
  delete '/volunteer/:id', to: "volunteers#destroy"
  delete '/volunteers', to: "volunteers#remove_all"

  # ROUTES FOR AUTHENTICATION
  resources :users, only: [:create]
  post '/login', to: 'users#login'
  get '/auto_login', to: 'users#auto_login'
  get '/users', to: 'users#index'
  get '/user/:id', to: 'users#show'
  delete '/user/:id', to: "users#destroy"
  patch '/user/:id', to: "users#update"
  put '/user/:id', to: "users#update"
end
