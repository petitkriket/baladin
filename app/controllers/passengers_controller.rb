class PassengersController < ApplicationController
  before_action :set_passenger, only: [:show, :edit, :update, :destroy]

  # GET /passengers
  # GET /passengers.json
  def index
    @passengers = Passenger.all
    @events  = Passenger.all.map { |u| u.events.published.last }
    @geojson = Array.new
    @events.each do |event|
          #if event.published?
          unless event.blank?
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [event.longitude, event.latitude]
          },
          properties: {
            markerurl: event.photo.marker.url,
            id: event.passenger.id,
            passenger: "#{t('passenger_number')}#{event.passenger.name}",
            popupContent: "<img src='#{event.photo.medium.url}' alt='#{event.passenger.name}'><br> #{t('passenger_number')}#{event.passenger.name} #{t('location')} #{event.city},#{event.country}"
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
    @geojson = Array.new
    @events.each_with_index do |event, index|
      if index == 0
        # this is the first item
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [event.longitude, event.latitude]
          },
          properties: {
            markerurl: event.photo.marker.url,
            popupContent: "<img src='#{event.photo.medium.url}'><br> #{t('passenger_number')}#{event.passenger.name} #{t('exlocation')} #{event.city} #{event.country} #{t('holder')} #{event.user.name}"
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
            popupContent: "<img src='#{event.photo.medium.url}'><br> #{t('passenger_number')}#{event.passenger.name} #{t('location')} #{event.city} #{event.country} #{t('holder')} #{event.user.name}"
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
            popupContent: "<img src='#{event.photo.medium.url}'><br> #{t('passenger_number')}#{event.passenger.name} #{t('exlocation')} #{event.city} #{event.country} #{t('holder')} #{event.user.name}"
          }
        }
      end
    end

    respond_to do |format|
      format.html
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
        format.html { redirect_to @passenger, notice: 'Passenger was successfully created.' }
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
        format.html { redirect_to @passenger, notice: 'Passenger was successfully updated.' }
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
      params.require(:passenger).permit(:name, :shortcut, :token, :photo, :photo_cache,:remove_photo)
    end
end
