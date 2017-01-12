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
      post.content = item[:content][:text]
      if post.path == nil
        post.path = post.title.parameterize
      end
      post.save
    end

    render :json => {:success => true}
  end

end
