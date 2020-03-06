class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(new create)
  before_action :correct_user, only: %i(edit update destroy)
  before_action :load_post, only: %i(show edit update destroy)

  def index
    if params[:province]
      @posts = Post.search_post params
      @posts = @posts.send params[:house_type] if params[:house_type].present?

    else
      @posts = Post
    end
    @posts = @posts.order_by_created_desc.page(params[:page])
                   .per Settings.paginates_per_page
    respond_to :js
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
    if @post.save
      flash[:success] = t ".created_success"
      redirect_to root_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit
    @provinces = Province.pluck(:name, :id)
    @districts = @post.districts&.pluck(:name, :id)
    @wards = @post.wards&.pluck(:name, :id)
    @post_pictures = @post.post_pictures
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = t ".update_success"
      redirect_to @post
    else
      flash.now[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    status = @post.active? ? :inactive : :active

    if @post.update_attributes active: status
      respond_to :js
    else
      respond_to do |format|
        format.js{render inline: "alert(I18n.t('trashs.index.fail'))"}
      end
    end
  end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_path unless @post
  end
end
