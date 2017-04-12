template = ERB.new File.new("#{Rails.root}/config/blog.yml").read
BLOG_CONFIG = YAML.load template.result(binding)
BLOG_CONFIG["links"] = BLOG_CONFIG["links"] || []
BLOG_CONFIG["hidden_posts"] = BLOG_CONFIG["hidden_posts"] || []
