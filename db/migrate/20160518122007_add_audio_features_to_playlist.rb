class AddAudioFeaturesToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :danceability, :float
    add_column :playlists, :energy, :float
    add_column :playlists, :key, :integer
    add_column :playlists, :loudness, :float
    add_column :playlists, :mode, :integer
    add_column :playlists, :speechiness, :float
    add_column :playlists, :acousticness, :float
    add_column :playlists, :instrumentalness, :float
    add_column :playlists, :liveness, :float
    add_column :playlists, :valence, :float
    add_column :playlists, :tempo, :float
  end
end
