class RemoveFacebookIdFromArtists < ActiveRecord::Migration[6.0]
  def change
    remove_column :artists, :facebook_id, :string
  end
end
