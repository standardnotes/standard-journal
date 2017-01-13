class PostsController < ApplicationController
  def index
    @posts = Post.where(:published => true).all
  end

  def show
    @post = Post.find_by_path(params[:path])
    if !@post
      render_404
    end
  end

  def feed
   @posts = Post.where(:published => true).all
   respond_to do |format|
     format.rss { render :layout => false }
   end
 end

end
