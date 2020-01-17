module ApplicationHelper
  def full_title page_title = ""
    base_title = t "views.base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def avatar_img avatar_url
    avatar_default = Settings.avatar_default
    avatar_url.nil? ? avatar_default : avatar_url
  end
end
