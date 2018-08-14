class Passenger < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :shortcut, uniqueness: true
  validates :name, :shortcut, :photo, presence: true
  #
  mount_uploader :photo, PassengerUploader
  #
  validates_integrity_of :photo
  #
end
