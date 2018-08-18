class PassengersController < ApplicationController
  before_action :set_passenger, only: [:show, :edit, :list, :update, :destroy]
  before_action :admin_only, :except => [:index, :show, :list]
  before_action :enable_map_nav, only: [:index, :show]
  before_action :user_contact_form, only: [:show]

  # GET /passengers
  # GET /passengers.json
  def index
    @passengers = Passenger.all
    @events  = Passenger.all.map { |u| u.events.published.last }
    @geojson = Array.new
    @events.each do |event|

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
    @events  = Passenger.find(params[:id]).events.published
    @event  = Passenger.find(params[:id]).events.published.last
    @geojson = Array.new
    counter = -1

    @events.each_with_index do |event, index|
      marker_name = t('passenger_marker_text', name: event.passenger.name )
      counter =+ 1
      popup_photo = ""
      unless event.photo.medium.url.nil?
        popup_photo = "<img src='#{event.photo.medium.url}'>"
      end

      if index == 0 && @events.size == 1
        # this is the first item
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
            popupContent: "#{popup_photo}<br> #{marker_name} #{t('location')} #{event.city} #{event.country} #{t('holder')} #{event.user.name}"
          }
        }
      elsif index == @events.size - 1
        # this is the last item
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
            popupContent: "#{popup_photo}<br> #{marker_name} #{t('location')} #{event.city} #{event.country} #{t('holder')} #{event.user.name}"
          }
        }
      else
        # all other items
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [event.longitude, event.latitude]
          },
          properties: {
            markerurl: event.photo.marker.url,
            markerurl_fallback: event.passenger.photo.marker.url,
            title: "#{t('event')} #{counter}",
            divclass: "marker",
            popupContent: "#{popup_photo}<br> #{marker_name} #{t('exlocation')} #{event.city} #{event.country} #{t('holder')} #{event.user.name}"

          }
        }
      end
    end

    respond_to do |format|
      if @event.blank?
      format.html { redirect_to passengers_path, alert: "Ce Passager n'a pas encore de Parcours" }
      elsif
      format.html
      end
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end

  def list
    @passengers = Passenger.all
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
        format.html { redirect_to passengers_path, notice: 'Passenger was successfully created.' }
        format.json { render :show, status: :created, location: @passenger }
      else
        format.html { render :new }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /passengers/1
  # PATCH/PUT /passengers/1.json
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to passengers_path, notice: 'Passenger was successfully updated.' }
        format.json { render :show, status: :ok, location: @passenger }
      else
        format.html { render :edit }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1
  # DELETE /passengers/1.json
  def destroy
    @passenger.destroy
    respond_to do |format|
      format.html { redirect_to passengers_url, notice: 'Passenger was successfully destroyed.' }
      format.json { head :no_content }
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

    def admin_only
      unless user_signed_in? && current_user.admin?
        #redirect_to root_path, :alert => "Access denied. Seulement admin"
        redirect_to new_user_session_path, :alert => "Merci de vous connecter."
      end
    end

    # rediriger vers root si pas admin et vide
    def events_empty
      @events = Passenger.find(params[:id]).events.published.last
      if @events.nil?
        #redirect_to root_path, :alert => "Pas de passager ici" unless user_signed_in? && current_user.admin?
        redirect_to root_path unless user_signed_in? && current_user.admin?
      end
    end

    def enable_map_nav
      @map_nav = true
    end

    def user_contact_form
      @user_contact_form = true
    end

end
