class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :initialize_user
  before_action :passenger_list

  def initialize_user
      @contact = Contact.new
  end

  def passenger_list
    @passengers = Passenger.all
  end

  def set_locale
     if user_signed_in? && !current_user.locale.blank?
         I18n.locale = current_user.locale
     else
       I18n.locale = if params[:locale].present?
                       params[:locale]
                     else
                       extract_locale_from_accept_language_header
                     end

       if user_signed_in? && current_user.locale.blank?
         current_user.locale = I18n.locale
         current_user.save
       end
     end
   end

   def default_url_options(options={})
     #{ :locale => I18n.locale }
     { :locale => ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
   end

private

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

def after_sign_in_path_for(resource)
  if session[:user_return_to] == nil
    events_path
  else
    super
  end
end

end
