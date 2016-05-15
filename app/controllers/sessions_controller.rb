class SessionsController < ApplicationController
  include HTTParty
  debug_output $stdout

	def create
		if params[:code] != nil and params[:state] == session[:state]

  		tokens = HTTParty.post("https://accounts.spotify.com/api/token",
  			:body => { :code => params[:code],
  								 :redirect_uri => ENV['redirect'], 	
  								 :grant_type => 'authorization_code',
  								 :client_id => ENV['client_id'],
  								 :client_secret => ENV['client_secret']
  							 }, 
  			:headers => { 'Content-Type' => 'application/x-www-form-urlencoded'}) 

  		if tokens.code == 200
	  		token = tokens['access_token']
  			profile = HTTParty.get('https://api.spotify.com/v1/me',
  				:headers => {'Authorization' => 'Bearer ' + token},
          :debug_output => $stdout)
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

	def destroy
	end

end
