class NotificationsController < ApplicationController
  def index
    @notifications = PostFavorite.where(post_id: current_user.posts.pluck(:id)) if logged_in?
  end
end
