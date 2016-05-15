class UsersController < ApplicationController
  def new

  end

  def home
    @user = User.find_by(id: params[:id])

    if @user != nil
      #@playlists = HTTParty.get('https://api.spotify.com/v1/me/playlists',
      #    :headers => { 'Authorization' => 'Bearer ' + @user.access_token } )

      @playlists = @user.playlists.all
    end
  end


end
