require 'securerandom'

class WelcomeController < ApplicationController

	skip_before_action :authenticate

  def welcome
  end

  def spotify_login
  	session[:state] = SecureRandom.urlsafe_base64
  	redirect_to 'https://accounts.spotify.com/authorize/?client_id=' + ENV['client_id'] + '&response_type=code&redirect_uri=' + ENV['redirect'] + '&state=' + session[:state] + '&scope=playlist-read-private%20playlist-modify-public%20playlist-modify-private%20user-library-read%20user-library-modify'
  end

  def error
  	@error = params[:error]
  end

end
