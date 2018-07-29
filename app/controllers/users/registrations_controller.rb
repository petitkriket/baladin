class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]
   #before_action :check_has_access, only: [:new]
   #before_action :check_shortcut, only: [:new]
   rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /resource/sign_up
   def new
     super
     if params[:t]
    #@passenger = Passenger.find_by(shortcut: params[:shortcut]).id
    Rails.logger.debug("DEBUG: param passe ")
    #@event.passenger_id = @passenger
    end

     #if params[:q].blank?
       #redirect_to root_path and return
       #redirect_to(root_path, :notice => "Restricted access") and return
      #format.html { redirect_to action: :index, notice: 'Todo item was successfully created.' }
     #end
   end

  # POST /resource
   def create
     super
      # if resource.save
      #    @event = Event.new
      #    @event.user_id = resource.id
      #    @event.passenger_id = params[:user][:event][:passenger_id]
      #    @event.address = params[:user][:event][:address]
      #    @event.photo = params[:user][:event][:photo]
      #    ##Rails.logger.debug("My object: #{@event.address.inspect}")
      #    @event.published = false
      #    @event.save
      #  end

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
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, event_attributes: [:address, :user_id, :published, :photo]])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     #devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
     attributes = [:name, :email, :avatar]
     devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
     devise_parameter_sanitizer.permit(:account_update, keys: attributes)

   end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
     super(resource)
   end

  # The path used after sign up for inactive accounts.
   def after_inactive_sign_up_path_for(resource)
     super(resource)
   end
   # a supprimer
   def check_has_access
     @passenger = Passenger.find(params[:q])
    # redirect_to(root_path) if params[:q].blank? || @passenger.blank?
      if params[:q].blank? && @passenger.blank? || params[:t].blank? || @passenger.token != params[:t]
        redirect_to(root_path)
        flash[:alert] = 'Accès restreint'
      end
   #Rails.logger.debug("My object: #{@passenger.token.inspect}")
  end

  # a supprimer
  def check_shortcut
    @passenger = Passenger.where(shortcut: params[:q]).any?
    Rails.logger.debug("My object: #{@passenger}")

     unless @passenger == true
       redirect_to(root_path)
       flash[:alert] = 'Accès restreint'
     end
 end

  def record_not_found
    redirect_to(root_path)
  end
end
