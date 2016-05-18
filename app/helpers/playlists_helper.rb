module PlaylistsHelper

	def filter(playlist, track, tolerance )
		high = 1.0 + tolerance
		low = 1.0 - tolerance 
		audio_features = Hash.new

		audio_feature = {'danceability' => playlist.danceability,
										 'energy' => playlist.energy,
										 'acousticness' => playlist.acousticness}

		if playlist.user_id == session[:current_user]
			return true
		else
			track['audio_features'].each do |key, value|
				if audio_feature[key] != nil
					if value > audio_feature[key]+tolerance or value < audio_feature[key]-tolerance
						return false
					end
				end
			end
		end
			
		return true
	end

end

