class Post < ApplicationRecord
  def rendered_content
    PostsHelper.rendered_content_for_text(self.content).html_safe
  end

  def show_date
    BLOG_CONFIG["hidden_posts"].include?(self.path) ? false : true
  end

end
