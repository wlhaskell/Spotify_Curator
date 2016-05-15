Rails.application.routes.draw do

  root 'welcome#welcome'

  resources :playlists

  get 'callback' => 'sessions#create'

  get 'signout' => 'sessions#destroy'


  get 'users/new'

  get 'home' => 'users#home'

  get 'login' => 'users#login'

  get 'spotify' => 'welcome#spotify_login'

  get 'index' => 'playlists#index'

  get 'token' => 'playlists#token'




end
