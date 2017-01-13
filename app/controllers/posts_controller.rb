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

 def toggle_like
   uuid = params[:uuid]
   post = Post.find_by_uuid(uuid)
   key = "liked_#{uuid}"
   value = session[key]

   if value == nil || value == false
     session[key] = true
     post.like_count += 1
   else
     session[key] = false
     post.like_count -= 1
   end

   post.save

   render :json => {:liked => session[key], :like_count => post.like_count}
 end

end
