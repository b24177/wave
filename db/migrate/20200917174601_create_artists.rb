class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :location
      t.float  :longitude
      t.float  :latitude
      t.string :spotify_id
      t.string :facebook_id

      t.timestamps
    end
  end
end
