class Posts::PostFavoritesController < ApplicationController
  before_action :logged_in_user, :set_post, only: %i(create destroy)

  def create
    @notification = current_user.post_favorites.by_post(@post.id).first_or_create
    if @notification
      respond_to :js
      NotificationEmailWorker.perform_at(30.seconds.from_now, @post.user.email, user_url(@notification.user))
    else
      respond_to do |format|
        format.js{render inline: "alert(I18n.t('.error'))"}
      end
    end
  end

  def destroy
    if current_user.post_favorites.by_post(@post.id).destroy_all
      respond_to :js
    else
      respond_to do |format|
        format.js{render inline: "alert(I18n.t('.error'))"}
      end
    end
  end

  private

  def set_post
    @post = Post.find_by id: params[:post_id]
    return if @post

    flash[:danger] = t "posts.show.not_found"
    redirect_to root_path
  end
end
