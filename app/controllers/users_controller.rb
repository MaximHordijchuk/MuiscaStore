class UsersController < ApplicationController
  before_filter :ensure_admin!

  # get /users
  def index
    @users = User.all.page(params[:page])
  end

  # patch /users/grant_admin
  def grant_admin
    @user = User.find(params[:user][:id])
    respond_to do |format|
      if @user.update_attribute(:admin, true)
        format.html { redirect_to users_path, notice: 'User was successfully granted.' }
      else
        format.html { redirect_to users_path, alert: 'User wasn\'t grunted.' }
      end
    end
  end

  # patch /users/prohibit_admin
  def prohibit_admin
    @user = User.find(params[:user][:id])
    if @user == current_user
      redirect_to users_path, alert: 'You cannot change your privileges.'
    else
      if @user.update_attribute(:admin, false)
        redirect_to users_path, notice: 'User was successfully prohibited.'
      else
        redirect_to users_path, alert: 'User wasn\'t prohibited.'
      end
    end
  end

  # delete /users
  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to users_path, alert: 'You cannot destroy yourself.'
    else
      @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
    end
  end

  private

  def ensure_admin!
    unless current_user.try(:admin?)
      redirect_to root_path, alert: 'Permission denied.'
      false
    end
  end
end