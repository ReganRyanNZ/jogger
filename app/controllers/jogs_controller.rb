class JogsController < ApplicationController
  respond_to :html, :js

  def new
    @jog = Jog.new
  end

  def create
    @jog = Jog.new(jog_params)
    @jog.user_id = params[:jog][:user_id].present? ? params[:jog][:user_id] : current_user.id
    @jog.save
  end

  private

  def jog_params
    return admin_jog_params if current_user.admin?
    params.require(:jog).permit(:time, :distance, :date)
  end

  def admin_jog_params
    params.require(:jog).permit(:user_id, :time, :distance, :date)
  end

end