class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.find(12)
  end

  def show
    @post = Post.find(params[:id])
  end
end
