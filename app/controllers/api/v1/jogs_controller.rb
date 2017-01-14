class Api::V1::JogsController < ApplicationController
  before_action :set_jog, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!
  before_action :authorize!, except: [:create]
  respond_to :json

  def show
    respond_with @jog
  end

  def create
    jog = Jog.new(jog_params)
    jog.user_id ||= current_api_user.id
    if jog.save
      render json: jog, status: 201, location: [:api, jog]
    else
      render json: { errors: jog.errors }, status: 422
    end
  end

  def update
    if @jog.update(jog_params)
      render json: @jog, status: 200, location: [:api, @jog]
    else
      render json: { errors: @jog.errors }, status: 422
    end
  end

  def destroy
    @jog.destroy
    head 204
  end

  private

  def authorize!
    unless (current_api_user.id == @jog.user.id) || (current_api_user.role.in? ["manager", "admin"])
      render json: { errors: "Not authorized", role: current_api_user.role }, status: :unauthorized
    end
  end

  def set_jog
    @jog = Jog.find(params[:id])
  end

  def jog_params
    return admin_jog_params if current_api_user.admin?
    params.require(:jog).permit(:time, :distance, :date)
  end

  def admin_jog_params
    params.require(:jog).permit(:user_id, :time, :distance, :date)
  end

end