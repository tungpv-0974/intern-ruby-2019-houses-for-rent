class NotificationsController < ApplicationController
  before_action :load_notification, only: %i(destroy update)

  def update
    if @notification.update_attributes(status: :seen)
      redirect_to @notification.user
    else
      respond_to do |format|
        format.js{render inline: "alert(I18n.t('.error'))"}
      end
    end
  end

  def destroy
    if @notification.update_attributes(status: :inactive)
      respond_to :js
    else
      respond_to do |format|
        format.js{render inline: "alert(I18n.t('.error'))"}
      end
    end
  end

  private

  def load_notification
    @notification = PostFavorite.find_by id: params[:id]
    return if @notification

    redirect_to root_path
  end
end
