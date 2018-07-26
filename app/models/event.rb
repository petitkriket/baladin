class Event < ApplicationRecord
  belongs_to :passenger
  belongs_to :user
end
