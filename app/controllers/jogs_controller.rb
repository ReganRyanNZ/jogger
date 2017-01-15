class JogsController < ApplicationController
  respond_to :html, :js
  before_action :set_jogs, only: [:create, :update, :destroy, :filter_dates]
  before_action :set_jog, only: [:edit, :update, :destroy]

  def new
    @jog = Jog.new
  end

  def create
    @jog = Jog.new(jog_params)
    @jog.user_id = params[:jog][:user_id].present? ? params[:jog][:user_id] : current_user.id
    @jog.time = @jog.time
    @jog.save
  end

  def update
    @jog.update_attributes(jog_params)
  end

  def destroy
    @jog.destroy
  end

  def new_date_filter
  end

  def filter_dates
    @jogs = @jogs.where(date: date_range_from_params)
  end

  private

  def date_range_from_params
    from = params[:date_range][:from].empty? ? @jogs.sort_by(&:date).first.date.strftime("%B %d, %Y") : params[:date_range][:from]
    to = params[:date_range][:to].empty? ? @jogs.sort_by(&:date).last.date.strftime("%B %d, %Y") : params[:date_range][:to]

    from = Date.parse(from)
    to = Date.parse(to) + 1.day

    from..to
  end

  def jog_params
    return admin_jog_params if current_user.admin?
    params.require(:jog).permit(:time, :distance, :date)
  end

  def admin_jog_params
    params.require(:jog).permit(:user_id, :time, :distance, :date)
  end

  def set_jogs
    @jogs = current_user.admin? ? Jog.all : current_user.jogs
  end

  def set_jog
    @jog = Jog.find(params[:id])
  end

end