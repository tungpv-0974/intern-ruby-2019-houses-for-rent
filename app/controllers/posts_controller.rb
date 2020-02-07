class PostsController < ApplicationController
  before_action :logged_in_user, :load_provinces, only: %i(new create)
  before_action :correct_user, only: :destroy
  before_action :load_post, only: :show
  before_action :load_posts, only: :index

  def index; end

  def show
    @post_pictures = @post.post_pictures
    @author = @post.user
  end

  def new
    @post = current_user.posts.build
    @post_picture = @post.post_pictures.build
  end

  def create
    ActiveRecord::Base.transaction do
      @post = current_user.posts.build post_params
      if @post.save!
        params[:post_pictures]["image_url"].each do |image|
          @post_picture = @post.post_pictures.create!(image_url: image)
        end
        flash[:success] = t ".created_success"
        redirect_to root_path
      else
        flash[:danger] = t ".create_fail"
        render :new
      end
    end
  end

  def destroy; end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS, Post::POST_PICTURE_PARAMS
  end
end
