module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def avatar_img
    avatar_default = Settings.avatar_default
    current_user.avatar_url? ? current_user.avatar_url.url : avatar_default
  end

  def house_types
    Post.house_types.keys.map{|key| [t("post.#{key}"), key]}
  end
end
