class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

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
    flash[:danger] = t "views.users.user_not_found"
    redirect_to login_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "views.users.user_not_found"
    redirect_to root_path
  end

  def load_province
    @province = Province.find_by id: params[:province_id]
    return if @province

    flash[:danger] = t "views.address.province_not_found"
    redirect_to root_path
  end

  def load_district
    @district = District.find_by id: params[:district_id]
    return if @district

    flash[:danger] = t "views.address.district_not_found"
    redirect_to root_path
  end
end
