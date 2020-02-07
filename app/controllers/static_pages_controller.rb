class StaticPagesController < ApplicationController
  before_action :load_posts, only: :home

  def home; end
end
