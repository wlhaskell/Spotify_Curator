class WelcomeController < ApplicationController

  def welcome
  end

  def spotify_login
  	redirect_to 'https://accounts.spotify.com/authorize/?client_id=8ef180761c73461fb294b0e2d9a740e0&response_type=code&redirect_uri=http://localhost:3000/login&scope=playlist-read-private%20playlist-modify-public%20playlist-modify-private%20user-library-read%20user-library-modify'
  end

end
