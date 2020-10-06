class PostsController < ApplicationController
  def index
    @posts = Post.all
    current_user.notifications.unread.update_all(read_at: Time.now)
    # User.first.notifications.update_all(read_at: nil)
  end

  def show
    @post = Post.find(params[:id])
  end
end
