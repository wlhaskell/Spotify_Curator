class SessionsController < ApplicationController
  
  skip_before_action :authenticate 

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
          session[:current_user] = user.id
        else
          redirect_to 'error?=' + tokens.code.to_s
				end
      else
        redirect_to 'error?=' + tokens.code.to_s
  		end

  		redirect_to home_path(:id => user.id)
    else
      playlist = Playlist.find_by(access_code: params[:access_code])
      if playlist != nil
        session[:current_user] = params[:access_code]
        redirect_to playlist_path(playlist)
      else
        redirect_to root_path
      end
  	end
	end

	def destroy
    user = User.find(session[:current_user])
    session[:current_user] = nil
    user.access_token = nil
    user.refresh_token = nil
    user.save
    redirect_to root_path
	end

end
