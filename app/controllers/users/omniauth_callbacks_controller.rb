# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :spotify
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
    else
      @user.save!
      # session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      # redirect_to new_user_registration_url
    end
    @artists = spotify_user.top_artists
    @artists.each do |artist|
      new_artist = Artist.create!(name: artist.name, spotify_id: artist.id) unless Artist.exists?(name: artist.name)
      UserArtist.create(artist: new_artist, user: @user, status: nil )
    end
    @playlists = spotify_user.playlists
    @playlists.each do |playlist|
      playlist.tracks.each do |track|
        track.artists.each do |artist|
          new_artist = Artist.create!(name: artist.name, spotify_id: artist.id) unless Artist.exists?(name: artist.name)
          UserArtist.create(artist: new_artist, user: @user, status: nil )
        end
      end
    end
  end

  def failure
    redirect_to root_path
  end
end
