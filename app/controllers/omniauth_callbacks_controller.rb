# frozen_string_literal: true
require 'open-uri'
require 'musicbrainz'

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
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

      sign_in_and_redirect @user, event: :authentication and return #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
    else
      @user.save!
      # session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      # redirect_to new_user_registration_url
    end
    get_top_artists(spotify_user)
  end

  def failure
    redirect_to root_path
  end

  private

  def get_top_artists(user)
    a = []
    if User.exists?(id: @user.id) && !@user.artists.nil?
      redirect_to posts_path
    elsif User.exists?(id: @user.id) && @user.artists.nil?
      user.top_artists.first(15).each do |artist|
        #@SC_urls = musicbrainz(artist.name, a)
        unless Artist.exists?(spotify_id: artist.id)
          new_artist = create_new_artist(artist)
        end
        UserArtist.find_or_create_by(artist: new_artist, user: @user)
      end
    else
      redirect_to posts_path
    end
  end

  #def musicbrainz(query, array)
  #  mb_artist = MusicBrainz::Artist.find_by_name(query)
  #  url = mb_artist.urls[:soundcloud]
  #  array << url if url
  #end

  def create_new_artist(artist)
    avatar = URI.open(artist.images.last['url'])
    new_artist = Artist.new(name: artist.name, spotify_id: artist.id)
    new_artist.photo.attach(io: avatar, filename: 'avatar', content_type: 'image/jpg')
    new_artist.save!
  end
end
