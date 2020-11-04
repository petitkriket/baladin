class ApplicationController < ActionController::Base
  include Concerns::AuthenticateStaging
  include ApplicationHelper
  before_action :set_locale
  before_action :passenger_list
  before_action :initialize_user
  before_action :set_raven_context
  rescue_from I18n::InvalidLocale, with: :locale_not_found

  def initialize_user
    @contact = Contact.new
  end

  def passenger_list
    @passengers = Passenger.all.order(id: :asc)
    jsTranslations
  end

  def set_locale
    if request.format == 'text/html'
      I18n.locale = extract_locale_from_accept_language_header if params[:locale].blank? && current_user.nil?

      I18n.locale = current_user.locale if params[:locale].blank? && current_user

      I18n.locale = params[:locale] if params[:locale] && current_user.nil?

      I18n.locale = params[:locale] || current_user.locale if params[:locale] && current_user

      if current_user && (current_user.locale.to_sym != I18n.locale.to_sym) && (controller_name != 'sessions' && action_name != 'create')
        current_user.locale = params[:locale]
        current_user.save
      end
    end

    if request.format == 'application/json'
      I18n.locale = params[:locale] if current_user.nil?
      I18n.locale = current_user.locale if current_user
    end
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  private

  def extract_locale_from_accept_language_header
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first).try(:to_sym)
    if I18n.available_locales.include? browser_locale
      browser_locale
    else
      I18n.default_locale
    end
  end

  def after_sign_in_path_for(resource)
    I18n.locale = resource.locale
    if session[:user_return_to].nil?
      events_path
    else
      super
    end
  end

  def locale_not_found
    redirect_to "/#{I18n.locale}", alert: t('invalid_url')
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
