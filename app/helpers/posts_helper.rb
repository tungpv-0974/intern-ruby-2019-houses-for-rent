module PostsHelper
  def post_baner post
    default = Settings.avatar_default
    post.post_pictures.empty? ? default : post.image_first.image.url
  end

  def content_first_half post
    post.content.truncate(Settings.index_split, omission: "")
  end

  def content_second_half post
    post.content.slice(Settings.index_split..@post.content.size)
  end
end
