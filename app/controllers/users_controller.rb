class UsersController < ApplicationController

	before_action :authenticate_user

  def new

  end

  def home
    @user = User.find_by(id: params[:id])

    if @user != nil
      @playlists = @user.playlists.all
    end
  end

  private

  def authenticate_user
  	if params[:id].to_i != session[:current_user]
  		redirect_to root_path
  	end
  end

end
