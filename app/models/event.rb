class Event < ApplicationRecord
  belongs_to :passenger
  belongs_to :user, optional: true
  validates :address, presence: true
  validates :passenger_id, :uniqueness => {:scope=>:user_id}
  scope :published, -> { where(:published => true)}
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

  def update_fired
  if self.id.any?
    @passenger = Passenger.find(self[:passenger_id])
    @event = self
    @previous_user = User.includes(:events).where(events: { passenger_id: self[:passenger_id], published: true }).order(created_at: :desc).first
    NotifMailer.event_activation_email(self.user, @passenger, @event).deliver if self.published

    unless @previous_user.nil?
    NotifMailer.event_activation_previous_user_email(@previous_user, @passenger, @event).deliver if self.published
    end
  end
  end

  end
