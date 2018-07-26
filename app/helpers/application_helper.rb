module ApplicationHelper
  def jsTranslations
    gon.gpsErrorMsg = I18n.t 'geolocate_failure'
  end
end
