class CreateUserArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_artists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
