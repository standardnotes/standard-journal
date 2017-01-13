class PostsController < ApplicationController

  def published_posts
    posts = Post.where(:published => true).order("created_at desc").all
    posts = posts.reject { |e| BLOG_CONFIG["hidden_posts"].include? e.path  }
    posts
  end

  def index
    @posts = published_posts
  end

  def show
    @post = Post.find_by_path(params[:path])
    if !@post
      render_404
    end
  end

  def feed
   @posts = published_posts
   respond_to do |format|
     format.rss { render :layout => false }
   end
 end

end
