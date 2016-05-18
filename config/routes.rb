Rails.application.routes.draw do


  root 'welcome#welcome'

  delete 'playlists/tracks' => 'playlists#destroy_track'

  post 'playlists/tracks' => 'playlists#add_track'

  post 'playlists/apply_filters' => 'playlists#apply_filters'

  resources :playlists

  get 'error' => 'welcome#error'

  get 'callback' => 'sessions#create'

  get 'logout' => 'sessions#destroy'

  get 'users/new'

  get 'home' => 'users#home'

  get 'login' => 'users#login'

  get 'spotify' => 'welcome#spotify_login'

  get 'index' => 'playlists#index'





end
