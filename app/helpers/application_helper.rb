module ApplicationHelper

  def format_distance distance_in_meters
    (distance_in_meters/1000.0).to_s + "km"
  end

  def format_time time_in_milliseconds
    minutes = (time_in_milliseconds/100/60)
    minutes.to_s + (minutes == 1 ? " minute" : " minutes")
  end

  def format_date date
    date.strftime("%A, %d %b %Y—%l:%M %p")
  end

  def format_speed speed
    speed.round(1).to_s + " km/h"
  end

  def ms_to_min ms
    ms / 100.0 / 60
  end

  def ms_to_h ms
    ms / 100.0 / 60 / 60
  end

  def m_to_km m
    m / 1000.0
  end
end
