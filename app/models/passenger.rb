class Passenger < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :events, dependent: :destroy
  has_one :last_validated_event, -> { where(published: true) }, class_name: 'Event'
  validates :shortcut, uniqueness: true
  validates :name, :shortcut, presence: true
  mount_uploader :photo, PassengerUploader
  validates_integrity_of :photo

  private

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
