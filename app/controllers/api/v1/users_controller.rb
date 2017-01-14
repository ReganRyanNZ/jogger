class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :update, :destroy]
  before_action :authorize!, only: [:show, :update, :destroy]
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user.regular? ? user_params : super_user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

  def authorize!
    unless (current_api_user.id.to_s == params[:id]) || (current_api_user.role.in? ["manager", "admin"])
      render json: { errors: "Not authorized", role: current_api_user.role }, status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def super_user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end