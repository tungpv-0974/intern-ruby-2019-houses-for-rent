module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def house_types
    Post.house_types.keys.map{|key| [t("post.#{key}"), key]}
  end
end
