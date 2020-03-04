
class PostedsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @posteds = current_user.posts.active.page(params[:page])
                           .per Settings.paginates_per_page
  end
end
