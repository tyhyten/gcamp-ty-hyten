class SessionsController < ApplicationController
  # before_action :set_previous_page
  #
  # def set_previous_page
  #    session[:return_to] = request.fullpath
  # end

  def new
    @user = User.new
    # I think this can be deleted
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      log_in @user
      if session[:return_to] == nil
      redirect_to projects_path, notice: 'User was successfully signed in'
      else
      redirect_to session[:return_to] , notice: 'User was successfully signed in'
      end

    else
      @user = User.new # can delete this?
      @user.errors[:base] << ("User/Password incorrect")
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: 'User was successfully signed out'
  end
end
