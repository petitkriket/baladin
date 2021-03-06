module MapHelper
  include ActionView::Helpers::DateHelper

  # show last passengers location
  def map_index_helper(data)
    markers_index = []
    events = data

    events.each do |event|
      next if event.blank?

      # name and url for index
      marker_name = t('passenger_marker_text', name: event.passenger.name)
      marker_url = url_for(passenger_path(event.passenger))

      # display current photo or default
      photo = if event.photo.marker.url.blank?
                event.passenger.photo.marker.url.to_s
              else
                event.photo.marker.url.to_s
              end

      # marker html
      marker_html = '<a href="' + marker_url + '"><img src="' + photo + '" class="img-marker" alt="Image"><p class="text-center"><mark>' + marker_name + '</mark></p></a>'

      # build index page markers
      markers_index << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [event.longitude, event.latitude]
        },
        properties: {
          marker_html: marker_html,
          id: event.passenger.id,
          divclass: 'marker'
        }
      }
    end

    # make data available to js
    gon.passengers = markers_index
  end

  # show every location of a single passenger
  def map_events_helper(data, has_popup)
    markers_index = []
    @events = Passenger.find(data.id).events.includes([:user]).published
    @events.each_with_index do |event, index|
      # display event photo or default as marker
      photo = if event.photo.marker.url.blank?
                event.passenger.photo.marker.url.to_s
              else
                event.photo.marker.url.to_s
              end

      # photo inside popup
      popup_photo = if event.photo.medium.url.nil?
                      "<img src='#{event.passenger.photo.thumb.url}'>"
                    else
                      "<img src='#{event.photo.thumb.url}'>"
                    end

      # passenger name and relative time spent with user inside popup
      passenger_name = t('passenger_marker_text', name: event.passenger.name)
      grabbed_on = t('since', date: time_ago_in_words(event.created_at))

      # Set marker position and popup content according to state
      # first and only marker
      if index == 0 && @events.size == 1
        marker_name = t('departure')
        marker_class = 'first_marker'
        user_name = event.user ? event.user.name : '-'
        marker_popup = "#{popup_photo}<br> #{passenger_name} #{t('location')} #{event.city} (#{event.country_name}) #{t('holder')} #{user_name}"

      # first with many markers
      elsif index == 0 && @events.size != 1
        marker_name =  t('departure')
        marker_class = 'marker'
        user_name = event.user ? event.user.name : '-'
        marker_popup = "#{popup_photo}<br> #{marker_name} #{t('exlocation')} #{event.city} (#{event.country_name}) #{t('holder')} #{user_name} #{grabbed_on}"

      # last marker
      elsif index == @events.size - 1
        marker_name = '<mark>' + t('current_position') + '</mark>'
        marker_class = 'last-marker'
        user_name = event.user ? event.user.name : '-'
        marker_popup = "#{popup_photo}<br> #{passenger_name} #{t('location')} #{event.city} (#{event.country_name}) #{t('holder')} #{user_name}"
        if controller_name == 'registrations'
          marker_name = '<mark>' + t('last_known_position') + '</mark>'
          marker_class = 'marker'
        end
      # markers in between
      else
        marker_name = t('event') + ' ' + index.to_s
        marker_class = 'marker'
        user_name = event.user ? event.user.name : '-'
        marker_popup = "#{popup_photo}<br> #{passenger_name} #{t('exlocation')} #{event.city} (#{event.country_name}) #{t('holder')} #{user_name} #{grabbed_on}"
      end

      # marker html
      marker_html = '<img src="' + photo + '" class="img-marker img-circle ' + marker_class + '" alt="Image"><p class="text-center">' + marker_name + '</p>'

      # first item alone
      markers_index << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [event.longitude, event.latitude]
        },
        properties: {
          markerurl: event.photo.marker.url,
          markerurl_fallback: event.passenger.photo.marker.url,
          marker_html: marker_html,
          divclass: marker_class
          # popupContent: marker_popup
        }.tap { |g| g[:popupContent] = marker_popup if has_popup }

      }
    end

    # push to js
    gon.events = markers_index
  end
end
