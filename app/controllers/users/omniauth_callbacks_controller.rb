# frozen_string_literal: true
require 'open-uri'

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
    @artists = spotify_user.top_artists(limit: 50, time_range: 'short_term')
    @artists.each do |artist|
      avatar = URI.open(artist.images.last['url'])
      new_artist = Artist.new(name: artist.name, spotify_id: artist.id)
      new_artist.photo.attach(io: avatar, filename: 'avatar', content_type: 'image/jpg')
      new_artist.save
      UserArtist.create(artist: new_artist, user: @user, status: nil)
    end
  end

  def failure
    redirect_to root_path
  end
end
