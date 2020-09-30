class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
    @posts = Post.all.where(artist: @artist)
  end

  def update; end

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
end
