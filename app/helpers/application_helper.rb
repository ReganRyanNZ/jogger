module ApplicationHelper

  def format_distance distance_in_meters
    (distance_in_meters/1000.0).round(3).to_s + "km"
  end

  def format_time minutes
    minutes.to_s + (minutes == 1 ? " minute" : " minutes")
  end

  def format_date date
    date.strftime("%A, %d %b %Y—%l:%M %p")
  end

  def format_speed speed
    speed.round(1).to_s + " km/h"
  end

  def avg_distance week
    week.sum{ |jog| jog.distance } / week.size.to_f
  end

  def avg_speed week
    week.sum{ |jog| jog.speed } / week.size.to_f
  end
end
