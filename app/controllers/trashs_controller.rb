
class TrashsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @trashs = current_user.posts.inactive.page(params[:page])
                          .per Settings.paginates_per_page
  end
end
