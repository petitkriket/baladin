class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, only: [:show, :destroy]
  before_action :user_menu, only: [:index]

  # GET /events
  # GET /events.json
  def index
    if current_user.try(:admin?)
    @events = Event.all.order('created_at DESC')
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

  unless current_user.try(:admin?)
    # check if shortcut exist and redirect if it does not exist
    if params[:shortcut] && Passenger.where(shortcut: params[:shortcut]).any? && Passenger.where(shortcut: params[:shortcut]).any?
      @passenger = Passenger.find_by(shortcut: params[:shortcut]).id
      @event.passenger_id = @passenger
    else
      redirect_to events_path, :alert => t(:event_wrong_shortcut)
    end
  end

    # check if user have any history with the corresponding passenger
    corresponding_passenger = Passenger.where(shortcut: params[:shortcut]) unless params[:shortcut].blank?
    if Event.where(:user_id => current_user.id, :passenger_id => corresponding_passenger).any?
      redirect_to events_path, :alert => t(:event_already_registred)
    end

  end

  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    # new event tagged to the current user
    unless current_user.try(:admin?)
      @event.user_id = current_user.id
    end

    # new event tagged to the corresponding passenger
    if params[:shortcut]
    @passenger = Passenger.find_by(shortcut: params[:shortcut]).id
    @event.passenger_id = @passenger
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: t(:event_created) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: t(:event_updated) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: t(:event_destroyed) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:address, :city, :country, :latitude, :longitude, :photo, :photo_cache,:remove_photo, :published, :passenger_id, :user_id, :created_at)
    end

    # admin only
    def admin_only
      unless user_signed_in? && current_user.admin?
        redirect_to passenger_path(id: @event.passenger_id)
      end
    end

    # show user contextual menu
    def user_menu
      @user_menu = true
    end

end
