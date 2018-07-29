class Event < ApplicationRecord
  belongs_to :passenger
  belongs_to :user, optional: true
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

  end
