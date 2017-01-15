class Jog < ApplicationRecord
  belongs_to :user

  validates_presence_of :time
  validates_presence_of :date
  validates_presence_of :distance
  validates_presence_of :user

  def speed
    (distance/1000.0) / (time/60.0)
  end

  def week
    self.date.strftime('Week %W, %Y')
  end
end
