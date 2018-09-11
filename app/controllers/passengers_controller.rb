class PassengersController < ApplicationController
  before_action :set_passenger, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, :only => [:edit, :update, :destroy]
  before_action :enable_map_nav, only: [:index, :show]
  before_action :user_contact_form, only: [:show]
  include ActionView::Helpers::DateHelper

  # GET /passengers
  # GET /passengers.json
  def index
    @geojson = Array.new
    events  = Passenger.all.map { |u| u.events.published.last }
    events.each do |event|
      unless event.blank?
        marker_name = t('passenger_marker_text', name: event.passenger.name )
        marker_url = url_for(passenger_path(event.passenger))
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [event.longitude, event.latitude]
          },
          properties: {
            markerurl: event.photo.marker.url,
            markerurl_fallback: event.passenger.photo.marker.url,
            id: event.passenger.id,
            link: "#{marker_url}",
            passenger: "#{marker_name}"
            }
          }
      end
end

respond_to do |format|
  format.html
  format.json { render json: @geojson }  # respond with the created JSON object
end
  end

  # GET /passengers/1
  # GET /passengers/1.json
  def show
    @geojson = Array.new
    @events  = Passenger.find(params[:id]).events.published
    @events.each_with_index do |event, index|
      marker_name = t('passenger_marker_text', name: event.passenger.name )
      popup_photo = ""
      grabbed_on = t('since', date: time_ago_in_words(event.created_at))
      unless event.photo.medium.url.nil?
        popup_photo = "<img src='#{event.photo.medium.url}'>"
      end

      # first item alone
      if index == 0 && @events.size == 1
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [event.longitude, event.latitude]
          },
          properties: {
            markerurl: event.photo.marker.url,
            markerurl_fallback: event.passenger.photo.marker.url,
            title: "#{t('departure')}",
            divclass: "first-marker",
            popupContent: "#{popup_photo}<br> #{marker_name} #{t('location')} #{event.city} (#{event.country_name}) #{t('holder')} #{event.user.name}"
          }
        }

      # first item with many
      elsif index == 0 && @events.size != 1
          @geojson << {
            type: 'Feature',
            geometry: {
              type: 'Point',
              coordinates: [event.longitude, event.latitude]
            },
            properties: {
              markerurl: event.photo.marker.url,
              markerurl_fallback: event.passenger.photo.marker.url,
              title: "#{t('departure')}",
              divclass: "marker",
              popupContent: "#{popup_photo}<br> #{marker_name} #{t('exlocation')} #{event.city} (#{event.country_name}) #{t('holder')} #{event.user.name} #{grabbed_on}"
            }
          }

      # last item
      elsif index == @events.size - 1
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [event.longitude, event.latitude]
          },
          properties: {
            markerurl: event.photo.marker.url,
            markerurl_fallback: event.passenger.photo.marker.url,
            title: "<mark>#{t('current_position')}</mark>",
            divclass: "last-marker",
            popupContent: "#{popup_photo}<br> #{marker_name} #{t('location')} #{event.city} (#{event.country_name}) #{t('holder')} #{event.user.name}"
          }
        }

      # all other items
      else
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [event.longitude, event.latitude]
          },
          properties: {
            markerurl: event.photo.marker.url,
            markerurl_fallback: event.passenger.photo.marker.url,
            title: "#{t('event')} #{index}",
            divclass: "marker",
            popupContent: "#{popup_photo}<br> #{marker_name} #{t('exlocation')} #{event.city} (#{event.country_name}) #{t('holder')} #{event.user.name} #{grabbed_on}"

          }
        }
      end
    end

    respond_to do |format|
      if @events.blank?
      format.html { redirect_to root_path, alert: t(:passenger_empty) } # if none published
      elsif
      format.html
      end
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end


  # GET /passengers/new
  def new
    @passenger = Passenger.new
  end

  # GET /passengers/1/edit
  def edit
  end

  # POST /passengers
  # POST /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)

    respond_to do |format|
      if @passenger.save
        format.html { redirect_to passengers_path, notice: t(:passenger_created) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /passengers/1
  # PATCH/PUT /passengers/1.json
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to passengers_path, notice: t(:passenger_updated) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /passengers/1
  # DELETE /passengers/1.json
  def destroy
    @passenger.destroy
    respond_to do |format|
      format.html { redirect_to passengers_url, notice: t(:passenger_destroyed) }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_passenger
      @passenger = Passenger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def passenger_params
      params.require(:passenger).permit(:name, :shortcut, :photo, :photo_cache,:remove_photo)
    end

    # addmin only
    def admin_only
      unless user_signed_in? && current_user.admin?
        redirect_to new_user_session_path, alert: t(:admin_only)
      end
    end

    # show map navigation
    def enable_map_nav
      @map_nav = true
    end

    # show last user contact form
    def user_contact_form
      @user_contact_form = true
    end

    #error handling
    rescue_from ActiveRecord::RecordNotFound do |exception|
      redirect_to :root, alert: t(:passenger_not_found)
    end

end
