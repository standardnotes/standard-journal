class PostsController < ApplicationController
  def index
    @posts = Post.where(:published => true).all
  end

  def show
    @post = Post.find_by_path(params[:path])
  end
end
