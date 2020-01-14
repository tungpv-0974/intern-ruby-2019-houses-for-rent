class ApplicationController < ActionController::Base
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

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "views.users.new.not_found"
    redirect_to root_path
  end
end
