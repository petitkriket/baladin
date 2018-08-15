class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, only: [:show, :destroy]
  before_action :check_shortcut, only: [:new]

  # GET /events
  # GET /events.json
  def index
    if current_user.try(:admin?)
    @events = Event.all.order('created_at')
  else
    @events = Event.where(:user_id => current_user.id)
end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    #
    if params[:shortcut]
    @passenger = Passenger.find_by(shortcut: params[:shortcut]).id
    @event.passenger_id = @passenger
    end
    #
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    unless current_user.try(:admin?)
      @event.user_id = current_user.id
    end

    if params[:shortcut]
    @passenger = Passenger.find_by(shortcut: params[:shortcut]).id
    #Rails.logger.debug("DEBUG 2: #{@passenger}")
    @event.passenger_id = @passenger
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to passenger_path(id: @event.passenger_id), notice: "Event was successfully created" }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to passenger_path(id: @event.passenger_id), notice: "Event was successfully updated" }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:address, :city, :country, :latitude, :longitude, :photo, :photo_cache,:remove_photo, :published, :passenger_id, :user_id)
    end

    def admin_only
      unless user_signed_in? && current_user.admin?
        redirect_to passenger_path(id: @event.passenger_id)
      end
    end

    def check_shortcut
    passenger = Passenger.where(shortcut: params[:shortcut]).any?
       unless passenger == true || current_user.admin?
         redirect_to(events_path)
         flash[:alert] = "L'adresse saisie sur le Passager est incorrecte. Merci de saisir l'adresse gravée sur le Passager pour inscrire votre nouvelle participation."
      end
    end

end
