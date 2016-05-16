class UsersController < ApplicationController
  def new

  end

  def home
    @user = User.find_by(id: params[:id])

    if @user != nil
      @playlists = @user.playlists.all
    end

    


  end


end
