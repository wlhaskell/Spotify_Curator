Rails.application.routes.draw do

  root 'welcome#welcome'

  delete 'playlists/tracks' => 'playlists#destroy_track'

  post 'playlists/tracks' => 'playlists#add_track'

  resources :playlists

  get 'error' => 'welcome#error'

  get 'callback' => 'sessions#create'

  get 'logout' => 'sessions#destroy'

  get 'users/new'

  get 'home' => 'users#home'

  get 'login' => 'users#login'

  get 'spotify' => 'welcome#spotify_login'

  get 'index' => 'playlists#index'

  get 'token' => 'playlists#token'




end
