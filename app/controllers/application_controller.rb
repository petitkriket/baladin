class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_locale
  before_action :initialize_user
  before_action :passenger_list
  before_action :language_switcher
  include ActionView::Helpers::UrlHelper

  def initialize_user
    @contact = Contact.new
  end

  def passenger_list
    @passengers = Passenger.all
  end

private

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale

    if user_signed_in? && current_user.locale.blank?
      current_user.locale = I18n.locale
      current_user.save
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end


  def extract_locale_from_accept_language_header
  preferred_language = request.env['HTTP_ACCEPT_LANGUAGE'] || ''
  preferred_language = preferred_language.scan(/^[a-z]{2}/).first
  available_locales= ("en" "fr")
    if available_locales.include?(preferred_language)
      preferred_language
    else
      "en"
    end
  end

  def language_switcher
    preferred_language = request.env['HTTP_ACCEPT_LANGUAGE'] || ''
    preferred_language = preferred_language.scan(/^[a-z]{2}/).first
    available_locales= ("en" "fr")
      if available_locales.include?(preferred_language)
        @preferred_language = preferred_language
      end

    if @preferred_language.to_s != I18n.locale.to_s && current_page?(root_path)
      Rails.logger.debug("///////////////// root differente langue")
      Rails.logger.debug("pref lang : #{@preferred_language.to_s}")
      Rails.logger.debug("set lang : #{I18n.locale.to_s}")
      #flash[:alert] = "Souhaitez vous etre redirigé ?"
      #redirect_to root_path(locale: locale)
      redirect_to root_url(locale: @preferred_language)
    end

    #Rails.logger.debug("///////////////// root page") if current_page?(root_path)
  end

end
