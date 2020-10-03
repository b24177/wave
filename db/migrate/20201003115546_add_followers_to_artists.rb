class AddFollowersToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :followers, :integer
  end
end
