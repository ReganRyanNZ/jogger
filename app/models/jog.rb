class Jog < ApplicationRecord
  belongs_to :user

  validates_presence_of :time
  validates_presence_of :date
  validates_presence_of :distance
  validates_presence_of :user
end
