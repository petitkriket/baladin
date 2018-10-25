class Event < ApplicationRecord
  belongs_to :passenger
  belongs_to :user, optional: true
  validates :address, presence: true
  validates :passenger_id, :uniqueness => {:scope=>:user_id, :message => I18n.t('event_already_registred_admin')}
  scope :published, -> { where(:published => true)}
  default_scope { order(created_at: :asc) }
  #
  mount_uploader :photo, EventUploader
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
  after_validation :coordinates_empty
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
      self.errors.add(:base, I18n.t('check_google_api'))
    end
  end

  def passenger_once
    if Event.where(:user_id => self.user.id, :passenger_id => self.passenger.id).any?
       self.errors.add(:base, I18n.t('event_already_registred_admin'))
    end
  end

  def country_name
   c = ISO3166::Country[self.country]
   return c.translations[I18n.locale.to_s] || c.name
  end

end
