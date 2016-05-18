class CreateAudioFeatures < ActiveRecord::Migration
  def change
    create_table :audio_features do |t|
      t.string :feature
      t.float :low
      t.float :high

      t.timestamps null: false
    end
  end
end
