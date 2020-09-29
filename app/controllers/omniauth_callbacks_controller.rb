# frozen_string_literal: true
require 'open-uri'
require 'musicbrainz'
require 'koala'

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
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
    else
      @user.save!
      # session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      # redirect_to new_user_registration_url
    end
    get_top_artists(spotify_user)
    #raise
  end

  def failure
    redirect_to root_path
  end

  private

  def get_top_artists(user)
    a = []
    user.top_artists.each do |artist|
      @fb_urls = musicbrainz(artist.name, a)
      unless Artist.exists?(spotify_id: artist.id)
        avatar = URI.open(artist.images.last['url'])
        new_artist = Artist.new(name: artist.name, spotify_id: artist.id)
        new_artist.photo.attach(io: avatar, filename: 'avatar', content_type: 'image/jpg')
        new_artist.save
      end
      UserArtist.find_or_create_by(artist: new_artist, user: @user)
    end
    facebook
    raise
  end

  def musicbrainz(query, array)
    mb_artist = MusicBrainz::Artist.find_by_name(query)
    urls = mb_artist.urls[:social_network]
    if urls
      if urls.class == Array
        urls.each do |url|
          array << url if url.include?('facebook.com') && !array.include?(url)
        end
      else
        array << urls
      end
    end
    array
  end

  def facebook
    @graph = Koala::Facebook::API.new(ENV['FB_ACCESS_TOKEN'])
    if @fb_urls
      query = url.split('/')[-1]
      artist = @graph.get_object(query)
      raise
  end
end
