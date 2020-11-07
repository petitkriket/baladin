class Users::ConfirmationsController < Devise::ConfirmationsController
  # respond_to :html
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    super(resource_name)
  end

  # The path used after confirmation.
  # Sign-in directly after confirmation and go to home page
  def after_confirmation_path_for(resource_name, resource)
    super(resource_name, resource)
    sign_in(resource)
    events_path
  end
end
