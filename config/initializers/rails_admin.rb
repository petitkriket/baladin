RailsAdmin.config do |config|
  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.current_user_method(&:current_user)

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.model 'JwtDenylist' do
    visible false
  end

  config.model 'User' do
    edit do
      field :role
      field :events
    end
  end

  config.model 'Passenger' do
    edit do
      field :name
      field :shortcut
      field :photo
      field :last_validated_event
      exclude_fields :slug, :events
    end
  end

  config.model 'Event' do
    edit do
      field :user
      field :passenger
      field :photo
      field :address

      field :latitude do
        read_only true
      end
      field :longitude do
        read_only true
      end
      field :city do
        read_only true
      end
      field :country do
        read_only true
      end
      field :published
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    # bulk_delete
    show
    edit
    delete
    # show_in_app
  end
end
