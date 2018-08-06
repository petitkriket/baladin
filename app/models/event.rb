class Event < ApplicationRecord
  belongs_to :passenger
  belongs_to :user, optional: true
  validates :address, presence: true
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
    NotifMailer.event_activation_email(self.user).deliver if self.published

    @previous_user = User.includes(:events).where(events: { passenger_id: self[:passenger_id], published: true }).order(created_at: :desc).first

    unless @previous_user.nil?
      NotifMailer.event_activation_previous_user_email(@previous_user).deliver if self.published
    end

    #Rails.logger.debug("mail envoyé au porteur précedent #{@previous_user.name}") unless @previous_user.nil?
    #Rails.logger.debug("concernant le passager #{self[:passenger_id]}")
  end

  end
