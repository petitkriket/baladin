class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]
   before_action :check_shortcut, only: [:new]
   rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /resource/sign_up
   def new
     if  Passenger.where(shortcut: params[:t]).any?
       @passenger = Passenger.where(shortcut: params[:t]).first.id
     end
   build_resource({})
   build_resource
   resource.events.build
#   Rails.logger.debug("My object: #{resource.events.build.passenger_id}")
   respond_with self.resource
   end

  # POST /resource
   def create
     super do
       @passenger = Passenger.where(shortcut: params[:t]).first.id
     end

     if @user.persisted?
        @admins = User.where(role: 'admin')
        @admins.each do |admin|
        NotifMailer.registration_email(@user, admin).deliver
        end

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
      #devise_parameter_sanitizer.permit(:sign_up, keys: [:name, event_attributes: [:user_id, :passenger_id, :address, :photo, :published]])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :locale, events_attributes: [:passenger_id, :address, :photo]])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     #devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
     devise_parameter_sanitizer.permit(:account_update, keys: [:name, :locale])

   #attributes = [:name, :email, :avatar]
   #devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
   #devise_parameter_sanitizer.permit(:account_update, keys: attributes)

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
  #@passenger = Passenger.where(shortcut: params[:q]).any?
  passenger = Passenger.where(shortcut: params[:t]).any?
  #@passenger = Passenger.where(shortcut: params[:t]).first.id

     unless passenger == true
       redirect_to(root_path)
       flash[:alert] = 'Vous devez avoir recu un Passager pour participer.'
    end
 end

 def already_registred
 if current_user.try(:admin?)
      redirect_to(events_path)
      flash[:info] = 'Coucou.'
   end
end

  def record_not_found
    redirect_to(root_path)
  end
end
