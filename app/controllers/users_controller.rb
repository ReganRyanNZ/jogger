class UsersController < ApplicationController
  respond_to :html, :js
  before_action :set_users, only: [:update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  def update
    @user.update_attributes(user_params)
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def set_users
    @users = User.all
  end

  def set_user
    @user = User.find(params[:id])
  end

end