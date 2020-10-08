class ArtistsController < ApplicationController

  def index
    @artists = current_user.artists
  end

  def show
    @artist = Artist.find(params[:id])
    @posts = Post.all.where(artist: @artist)
  end

  def follow
    @artist = Artist.find(params[:id])
    if current_user.follow(@artist.id)
      respond_to do |format|
        format.html { redirect_to artists_path }
        format.js
      end
    end
  end

  def unfollow
    @artist = Artist.find(params[:id])
    if current_user.unfollow(@artist.id)
      respond_to do |format|
        format.html { redirect_to artists_path }
        format.js { render action: :follow }
      end
    end
  end
  def discover
    spotify_id = current_user.user_artists.last.artist.spotify_id
    @artists = RSpotify::Artist.find(spotify_id).related_artists
  end
end
