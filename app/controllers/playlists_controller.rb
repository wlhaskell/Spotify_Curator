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

    if playlist.code == 201
      Playlist.create(name: params[:playlist][:name], spotify_id: playlist['id'], user_id: user.id)
    end

    redirect_to home_path(:id => user.id, :code => playlist.code)

  end

  def edit
  end

  def show
    @tracks = []
    @search = []
    playlist = Playlist.find(params[:id])
    user = User.find(playlist.user_id)
    @id = playlist.id
    tracks = HTTParty.get('https://api.spotify.com/v1/users/' + user.spotify_id + '/playlists/' + playlist.spotify_id + '/tracks?fields=items(track(name,uri))',
      :headers => {'Authorization' => 'Bearer ' + user.access_token})

    if tracks.code == 200
      tracks['items'].each do |track|
        @tracks.push track['track']
      end
    else
      redirect_to '/error?error=' + tracks.code.to_s
    end

    if params[:search] != nil
      results = HTTParty.get('https://api.spotify.com/v1/search?' +
        'q=' + params[:search].gsub(' ','+') +
        '&type=track' +
        '&market=US',
        :headers => {'Authorization' => 'Bearer ' + user.access_token})

      if results.code == 200
        results['tracks']['items'].each do |track|
          @search.push track
        end
      else
        redirect_to '/error?error=' + results.code.to_s
      end
    end

  end

  def destroy
    
  end

  def add_track

    playlist = Playlist.find(params[:id])
    user = User.find(playlist.user_id)
    add = HTTParty.post('https://api.spotify.com/v1/users/' + user.spotify_id + '/playlists/' + playlist.spotify_id + '/tracks',
      :headers => { 'Authorization' => 'Bearer ' + user.access_token,
                    'Content-Type' => 'appliaction/json'},
      :body => {'uris' => [params[:uri]]}.to_json)

      redirect_to playlist_path(playlist)

  end

  def destroy_track
    playlist = Playlist.find(params[:id])

    user = User.find(playlist.user_id)
    remove = HTTParty.delete('https://api.spotify.com/v1/users/' + user.spotify_id + '/playlists/' + playlist.spotify_id + '/tracks',
      :headers => { 'Authorization' => 'Bearer ' + user.access_token,
                    'Content-Type' => 'appliaction/json'},
      :body => {'tracks' => ['uri' => params[:uri]]}.to_json)

      redirect_to playlist_path(playlist)
  end

end
