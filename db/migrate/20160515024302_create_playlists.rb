class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :spotify_id
      t.string :access_code
      t.string :owner_id

      t.timestamps null: false
    end
  end
end
