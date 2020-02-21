class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :load_notification_user

  before_action :set_locale, :load_provinces

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include? locale
                    locale
                  else
                    I18n.default_locale
                  end
  end

  private
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.please_login"
    redirect_to login_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.user_not_found"
    redirect_to root_path
  end

  def load_province
    @province = Province.find_by id: params[:province_id]
    return if @province

    flash[:danger] = t "address.province_not_found"
    redirect_to root_path
  end

  def load_provinces
    @provinces = Province.pluck :name, :id
  end

  def load_district
    @district = District.find_by id: params[:district_id]
    return if @district

    flash[:danger] = t "address.district_not_found"
    redirect_to root_path
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = t "posts.show.not_found"
    redirect_to root_path
  end

  def load_posts
    @posts = Post.order_by_created_desc.page(params[:page]).per Settings.paginates_per_page
  end

  def load_notification_user
    @notifications = PostFavorite.where(post_id: current_user.posts.pluck(:id)) if logged_in?
  end
end
