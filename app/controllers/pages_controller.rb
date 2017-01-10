class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:home, :manager]
  before_action :set_all_users, only: [:manager]
  before_action :set_jogs, only: [:home]

  def home

  end

  def manager

  end

  private

  def set_user
    @user = current_user
  end

  def set_all_users
    @all_users = User.all
  end

  def set_jogs
    @jogs = current_user.jogs
  end
end