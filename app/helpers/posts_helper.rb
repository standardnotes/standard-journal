module PostsHelper
  def self.rendered_content_for_text(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true,
      prettify: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_spacing: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    return markdown.render(text)
  end
end
