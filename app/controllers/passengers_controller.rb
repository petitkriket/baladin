class PassengersController < ApplicationController
  before_action :set_passenger, only: %i[show edit update destroy]
  before_action :admin_only, only: %i[edit update destroy]
  before_action :enable_map_nav, only: %i[index show]
  before_action :user_contact_form, only: [:show]
  include MapHelper

  # GET /passengers
  def index
    events = Passenger.all.map { |u| u.events.published.last }

    # build map
    map_index_helper(events)

    # create html page
    respond_to do |format|
      format.html
    end
  end

  # GET /passengers/1
  def show
    @events = Passenger.friendly.find(params[:id])

    # build map
    map_events_helper(@events, true)

    # create html page or redirect if no markers, TODO RSS
    respond_to do |format|
      if @events.blank?
        format.html { redirect_to root_path, alert: t(:passenger_empty) } # if none published
      else
        format.html
      end
    end
  end

  # GET /passengers/new
  def new
    @passenger = Passenger.new
  end

  # GET /passengers/1/edit
  def edit; end

  # POST /passengers
  def create
    @passenger = Passenger.new(passenger_params)

    respond_to do |format|
      if @passenger.save
        format.html { redirect_to root_path, notice: t(:passenger_created) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /passengers/1
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to root_path, notice: t(:passenger_updated) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /passengers/1
  def destroy
    @passenger.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: t(:passenger_destroyed) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_passenger
    @passenger = Passenger.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def passenger_params
    params.require(:passenger).permit(:name, :shortcut, :photo, :photo_cache, :remove_photo)
  end

  # addmin only
  def admin_only
    redirect_to new_user_session_path, alert: t(:admin_only) unless user_signed_in? && current_user.admin?
  end

  # show map navigation
  def enable_map_nav
    @map_nav = true
  end

  # show last user contact form
  def user_contact_form
    @user_contact_form = true
  end

  # error handling
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    redirect_to :root, alert: t(:passenger_not_found)
  end
end
