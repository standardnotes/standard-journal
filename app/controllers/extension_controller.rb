class ExtensionController < ApplicationController

  before_action {
    secret = params[:secret]
    if secret != ENV['SECRET']
      render :json => {:error => "Not Authorized"}, :status => 401
    end
  }

  def show

    name = "Blog"
    supported_types = ["Note"]
    actions = [
      {
        :label => "Publish to Blog",
        :desc => "Publishes this note to your blog",
        :url => "#{ENV['HOST']}/ext/#{ENV['SECRET']}/put",
        :verb => "post",
        :context => "Note",
        :content_types => ["Note"],
        :permissions => "read",
        :accepts_decrypted => true,
        :accepts_encrypted => false
      },
    ]
    render :json => {:name => name, :supported_types => supported_types, :actions => actions}
  end

  def put
    items = params[:items]

    items.each do |item|
      post = Post.find_or_create_by(uuid: item[:uuid])
      post.title = item[:content][:title]
      content, params = content_and_params(item[:content][:text])
      post.content = content
      post.update(params)
      if post.path == nil
        post.path = post.title.parameterize
      end
      post.save
    end

    render :json => {:success => true}
  end

  def content_and_params(input)
    if input.start_with? "<params>"
      params_string = input.string_between_markers("<params>", "</params>")
      if params_string
        params_string = "<params>" + params_string + "</params>"
        params = Hash.from_xml(params_string.gsub("\n", ""))["params"]
        input.slice! params_string
      end
    end

    return input, params
  end

end

class String
  def string_between_markers marker1, marker2
    self[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end
end
