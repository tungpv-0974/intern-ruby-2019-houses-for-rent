class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(new create)
  before_action :correct_user, only: :destroy
  before_action :load_post, only: :show

  def index
    if params[:province]
      @posts = Post.search_post params
      @posts = @posts.send params[:house_type] if params[:house_type].present?

    else
      @posts = Post
    end
    @posts = @posts.order_by_created_desc.page(params[:page])
                   .per Settings.paginates_per_page
  end

  def show
    @post_pictures = @post.post_pictures
    @author = @post.user
  end

  def new
    @post = current_user.posts.build
    @post_picture = @post.post_pictures.build
  end

  def create
    @post = current_user.posts.build post_params
    ActiveRecord::Base.transaction do
      @post.save!
      params[:post_pictures]["image_url"].each do |image|
        @post_picture = @post.post_pictures.create!(image_url: image)
      end
      flash[:success] = t ".created_success"
      redirect_to root_path
    end
  rescue StandardError
    flash[:danger] = t ".create_fail"
    render :new
  end

  def destroy; end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS, Post::POST_PICTURE_PARAMS
  end
end
