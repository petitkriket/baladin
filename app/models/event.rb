class Event < ApplicationRecord
  belongs_to :passenger
  belongs_to :user, optional: true
  validates :address, presence: true
  validates :passenger_id, :uniqueness => {:scope=>:user_id, :message => "Title already exists."}
  scope :published, -> { where(:published => true)}
  default_scope { order(created_at: :asc) }

  #
  mount_uploader :photo, EventUploader
  #
  validates_integrity_of :photo
  #
  geocoded_by :address
      reverse_geocoded_by :latitude, :longitude do |obj,results|
      if geo = results.first
          obj.city    = geo.city
          obj.country = geo.country_code
      end
  end
  after_validation :geocode, :reverse_geocode ,:if => :address_changed?
  after_validation :update_fired, :if => :published_changed?
  after_validation :coordinates_empty, :if => :published_changed?
  after_validation :passenger_once, on: :create

  def update_fired
      if self.id
          @passenger = Passenger.find(self[:passenger_id])
          @event = self
          @previous_user = User.includes(:events).where(events: { passenger_id: self[:passenger_id], published: true }).order(created_at: :desc).first
          NotifMailer.event_activation_email(self.user, @passenger, @event).deliver if self.published

          unless @previous_user.nil?
            NotifMailer.event_activation_previous_user_email(@previous_user, @passenger, @event).deliver if self.published
          end
      end
    end

  def coordinates_empty
    if self.longitude == nil || self.latitude == nil
      self.published = nil
      self.errors.add(:base, "Vérifiez l'API Google. Vous pouvez les saisir latitude et longitude à la main.")
    end
  end

  def passenger_once
    if Event.where(:user_id => self.user.id, :passenger_id => self.passenger.id).any?
       self.errors.add(:base, "Vous avez deja enregistré une étape pour ce passager")
    end
  end
end
