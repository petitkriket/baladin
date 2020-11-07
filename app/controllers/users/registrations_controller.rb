class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :user_menu, only: [:edit]
  prepend_before_action :check_shortcut, only: [:new]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  invisible_captcha only: [:create]
  include MapHelper

  # GET /resource/sign_up
  def new
    @passenger = Passenger.find_by(shortcut: params[:t])
    map_events_helper(@passenger, true) if @passenger

    build_resource({})
    build_resource
    resource.events.build
    respond_with resource
  end

  # POST /resource
  def create
    super do
      @passenger = Passenger.find_by(shortcut: params[:t])
    end

    return unless @user.persisted?

    User.where(role: 'admin').each do |admin|
      NotifMailer.registration_email(@user, admin).deliver
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name, event_attributes: [:user_id, :passenger_id, :address, :photo, :published]])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :locale, events_attributes: %i[passenger_id address photo]])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    # devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name locale])

    # attributes = [:name, :email, :avatar]
    # devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    # devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  def check_shortcut
    passenger = Passenger.where(shortcut: params[:t]).any?
    if user_signed_in? && passenger == true
      redirect_to new_event_path(shortcut: params[:t])
      flash[:notice] = "Merci d'enregistrer votre nouveau Passager. TODO"
    end

    unless passenger == true
      redirect_to(root_path)
      flash[:alert] = 'Vous devez avoir recu un Passager pour participer. TODO'
    end
  end

  def record_not_found
    redirect_to(root_path)
  end

  def user_menu
    @user_menu = true
  end
end
