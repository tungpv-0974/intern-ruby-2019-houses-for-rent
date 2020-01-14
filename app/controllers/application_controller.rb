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
    flash[:danger] = t "static_pages.users.requite_login"
    redirect_to login_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "static_pages.users.notfound"
    redirect_to root_path
  end
end
