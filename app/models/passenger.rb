class Passenger < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :shortcut, uniqueness: true
  #
  validates :name, :shortcut, presence: true
end
