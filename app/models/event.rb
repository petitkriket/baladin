# frozen_string_literal: true

class Event < ApplicationRecord
  # relations
  belongs_to :passenger
  belongs_to :user, optional: true
  scope :published, -> { where(published: true) }
  scope :most_recent_by_passenger, -> do
    from(
      <<~SQL
        (
          SELECT events.*
          FROM events JOIN (
             SELECT passenger_id, max(created_at) AS created_at
             FROM events
             WHERE published=true
             GROUP BY passenger_id
          ) latest_by_passenger
          ON events.created_at = latest_by_passenger.created_at
          AND events.passenger_id = latest_by_passenger.passenger_id
        ) events
      SQL
    )
  end
  # validations
  validates :address, presence: true
  validates :user_id, presence: true
  validates :passenger_id,  presence: true, uniqueness: { scope: :user_id }

  # misc
  mount_uploader :photo, EventUploader
  validates_integrity_of :photo unless Rails.env.test?
  geocoded_by :address

  # hooks
  unless Rails.env.test?
    after_validation :geocode
    after_validation :validate_coordinates
    after_validation :fill_location_details
  end
  after_validation :update_fired

  def validate_coordinates
    return unless longitude.nil? || latitude.nil?

    self.published = nil
    errors.add(:base, I18n.t('invalid_address'))
  end

  def fill_location_details
    return unless address_changed?

    geo = Geocoder.search(address).first
    return unless geo.present?

    self.city = geo.city
    self.country = geo.country_code
  end

  def update_fired
    return unless id && published? && published_changed?

    NotifMailer.event_activation_email(user, passenger, self).deliver
    previous_user = User.includes(:events).where(events: { passenger_id: passenger.id, published: true })
                        .order(created_at: :desc).first
    NotifMailer.event_activation_previous_user_email(previous_user, passenger, self).deliver if previous_user
  end

  def country_name
    c = ISO3166::Country[country]
    c.translations[I18n.locale.to_s] || c.name
  end
end
