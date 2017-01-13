xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title BLOG_CONFIG["title"]
    xml.author BLOG_CONFIG["author_name"]
    xml.description BLOG_CONFIG["desc"]
    xml.link BLOG_CONFIG["url"]
    xml.language "en"

    for post in @posts
      xml.item do
        if post.title
          xml.title post.title
        else
          xml.title ""
        end
        xml.author BLOG_CONFIG["author_name"]
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link BLOG_CONFIG["url"] + "/" + post.path
        xml.guid post.uuid

        text = post.content
        xml.description "<p>" + text + "</p>"
      end
    end
  end
end
