Rails.application.routes.draw do
  root to: 'articles#index'
  resources 'articles'
  resources 'words', only: [:index]

  get '/search' => 'articles#search'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'


  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
