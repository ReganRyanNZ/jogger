class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_manager!, only: [:manager]
  before_action :set_users, only: [:manager]
  before_action :set_jogs, only: [:home, :report]

  def home
    redirect_to manager_path if current_user.manager?
  end

  def report
    @weeks = @jogs.group_by(&:week).sort
  end

  def manager

  end

  private

  def set_users
    @users = User.all
  end

  def set_jogs
    @jogs = current_user.admin? ? Jog.all : current_user.jogs
  end

  def authorize_manager!
    redirect_to root_path unless current_user.manager? || current_user.admin?
  end
end