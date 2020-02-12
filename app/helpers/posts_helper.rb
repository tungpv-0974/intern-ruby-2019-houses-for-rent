module PostsHelper
  def post_baner post
    default = Settings.avatar_default
    post.post_pictures.empty? ? default : post.image_first.image_url.url
  end
end
