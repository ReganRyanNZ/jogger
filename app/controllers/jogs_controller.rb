class JogsController < ApplicationController
  respond_to :html, :js
  before_action :set_jogs, only: [:create, :update, :destroy]
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

  private

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