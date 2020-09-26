class RemoveLatitudeLongitudeFromArtists < ActiveRecord::Migration[6.0]
  def change
    remove_column :artists, :latitude, :float
    remove_column :artists, :longitude, :float
  end
end
