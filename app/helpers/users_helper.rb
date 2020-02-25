module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  end

  def avatar_img user
    avatar_default = Settings.avatar_default
    user.avatar? ? user.avatar.url : avatar_default
  end
end
