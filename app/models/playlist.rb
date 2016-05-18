class Playlist < ActiveRecord::Base
	has_many :audio_feature
	belongs_to :user
end
