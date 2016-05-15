class PlaylistsController < ApplicationController
  include HTTParty
  debug_output $stdout

  def index

  end

  def new
    @playlist = Playlist.new
  end

  def create
    user = User.find(params[:playlist][:owner_id])  
    playlist = HTTParty.post('https://api.spotify.com/v1/users/' + user.spotify_id + '/playlists', 
      :body => { :name => params[:playlist][:name] }.to_json,
      :headers => { 'Authorization' => 'Bearer ' + user.access_token,
                    'Content-Type' => 'application/json'},
      :debug_output => $stdout) 

    if playlist.code == 200
      Playlist.create(name: params[:name], spotify_id: playlist['id'], owner_id: params[:owner_id])
    end

    redirect_to home_path(:id => user.id)

  end

  def edit
  end

  def destroy
    
  end

end