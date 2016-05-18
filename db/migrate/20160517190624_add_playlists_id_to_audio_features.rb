class AddPlaylistsIdToAudioFeatures < ActiveRecord::Migration
  def change
    add_column :audio_features, :playlist_id, :integer
  end
end
