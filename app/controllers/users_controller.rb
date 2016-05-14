class UsersController < ApplicationController
  def new

  end

  def home
    user = User.find_by(id: params[:id])

    if user != nil
      @playlists = HTTParty.get('https://api.spotify.com/v1/me/playlists',
          :headers => { 'Authorization' => 'Bearer ' + user.access_token } )
    end
  end

  def login
  	if params[:code] != nil

  		tokens = HTTParty.post("https://accounts.spotify.com/api/token",
  			:body => { :code => params[:code],
  								 :redirect_uri => 'http://localhost:3000/login', 	
  								 :grant_type => 'authorization_code',
  								 :client_id => ENV['client_id'],
  								 :client_secret => ENV['client_secret']
  							 }, 
  			:headers => { 'Content-Type' => 'application/x-www-form-urlencoded'}) 

  		if tokens.code == 200
	  		token = tokens['access_token']
  			profile = HTTParty.get('https://api.spotify.com/v1/me',
  				:headers => {'Authorization' => 'Bearer ' + token})
				if profile.code == 200
          user = User.find_by(spotify_id: profile['id'])
					if user != nil
            user.access_token = token
            user.refresh_token = tokens['refresh_token'] 
            user.save         
          else
						user = User.create(spotify_id: profile['id'], access_token: token, refresh_token: tokens['refresh_token'])
					end
				end
  		end

  		redirect_to home_path(:id => user.id)

  	end
  end
end
