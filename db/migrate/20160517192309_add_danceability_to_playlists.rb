class AddDanceabilityToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :danceability_low, :float
    add_column :playlists, :danceability_high, :float
  end
end
