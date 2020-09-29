class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_artists
  has_many :artists, through: :user_artists

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:spotify]

  def password_required?
    return false if spotify_id.present?
    super
  end

  def self.from_omniauth(auth)
    where(spotify_id: auth.info.id).first_or_create do |user|
      user.email = auth.info.email

      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def follow(artist_id)
    user_artists.find_or_create_by(artist_id: artist_id).update(status: "follow")
  end

  def unfollow(artist_id)
    user_artists.find_by(artist_id: artist_id).update(status: "unfollow")
  end

  def is_following?(artist_id)
    user_artists.where(artist_id: artist_id, status: "follow").exists?
   end
end
