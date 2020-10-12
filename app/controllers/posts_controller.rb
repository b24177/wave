class PostsController < ApplicationController
  def index
    @posts = Post.where(artist_id: followed_artists)
    current_user.notifications.unread.update_all(read_at: Time.now)
    # User.first.notifications.update_all(read_at: nil)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def followed_artists
    current_user.artists.select do |artist|
      UserArtist.where(artist_id: artist.id).first.status == 'follow'
    end
  end
end
