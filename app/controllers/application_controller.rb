class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    if I18n.available_locales.include? locale
      I18n.locale = locale
    else
      I18n.default_locale
    end
  end
end
